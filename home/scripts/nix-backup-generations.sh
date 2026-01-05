#!/usr/bin/env bash
# NixOS Generation Backup Manager
# Manages NixOS generations: marks backups, keeps last 3, ensures max 5 total
#
# Usage: sudo nix-backup-generations [--dry-run|-n]
#   --dry-run, -n    Show what would be done without making any changes

set -euo pipefail

PROFILE="/nix/var/nix/profiles/system"
BACKUP_MARKER_FILE="/nix/var/nix/profiles/system-backups.txt"
MAX_TOTAL_GENERATIONS=5
KEEP_LAST_N=3

# Parse arguments
DRY_RUN=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run|-n)
            DRY_RUN=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--dry-run|-n]"
            echo ""
            echo "Options:"
            echo "  --dry-run, -n    Show what would be done without making any changes"
            echo "  --help, -h       Show this help message"
            exit 0
            ;;
        *)
            echo "Error: Unknown option: $1" >&2
            echo "Use --help for usage information" >&2
            exit 1
            ;;
    esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_dry_run() {
    echo -e "${YELLOW}[DRY-RUN]${NC} $1"
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   log_error "This script must be run as root (use sudo)"
   exit 1
fi

# Show dry-run mode
if [[ "$DRY_RUN" == "true" ]]; then
    log_warn "DRY-RUN MODE: No changes will be made"
    echo ""
fi

# Parse generation list and extract generation number and timestamp
# Output format: generation_number|timestamp_epoch|date_string
parse_generations() {
    nix-env --list-generations --profile "$PROFILE" | \
        awk 'NR > 1 { 
            gen = $1; 
            date_str = $2 " " $3; 
            # Use GNU date (Linux) format
            cmd = "date -d \"" date_str "\" +%s 2>/dev/null";
            cmd | getline timestamp;
            close(cmd);
            if (timestamp) print gen "|" timestamp "|" date_str;
        }' | sort -t'|' -k2 -n
}

# Get current timestamp
now=$(date +%s)
one_day_ago=$((now - 86400))  # 24 hours in seconds
one_week_ago=$((now - 604800))  # 7 days in seconds

log_info "Analyzing generations..."

# Parse all generations
generations=()
while IFS='|' read -r gen_num timestamp date_str; do
    generations+=("$gen_num|$timestamp|$date_str")
done < <(parse_generations)

if [[ ${#generations[@]} -eq 0 ]]; then
    log_error "No generations found!"
    exit 1
fi

log_info "Found ${#generations[@]} generation(s)"

# Find generations to mark as backups
week_backup_gen=""
day_backup_gen=""
backup_gens=()

# Read existing backups from marker file
declare -A existing_backups
if [[ -f "$BACKUP_MARKER_FILE" ]]; then
    while IFS='|' read -r gen_num date_str; do
        existing_backups["$gen_num"]="$date_str"
    done < "$BACKUP_MARKER_FILE"
fi

# Find week-old backup (oldest generation >= 7 days old)
for gen_info in "${generations[@]}"; do
    IFS='|' read -r gen_num timestamp date_str <<< "$gen_info"
    if [[ $timestamp -le $one_week_ago ]]; then
        if [[ -z "$week_backup_gen" ]]; then
            week_backup_gen="$gen_num"
            log_info "Found week-old generation: $gen_num (from $date_str)"
        fi
    fi
done

# Find day-old backup (generation from yesterday or older, but not the week-old one)
for gen_info in "${generations[@]}"; do
    IFS='|' read -r gen_num timestamp date_str <<< "$gen_info"
    if [[ $timestamp -le $one_day_ago && "$gen_num" != "$week_backup_gen" ]]; then
        if [[ -z "$day_backup_gen" ]]; then
            day_backup_gen="$gen_num"
            log_info "Found day-old generation: $gen_num (from $date_str)"
        fi
    fi
done

# Mark backups
backup_date_format="%Y-%m-%d"
if [[ -n "$week_backup_gen" ]]; then
    for gen_info in "${generations[@]}"; do
        IFS='|' read -r gen_num timestamp date_str <<< "$gen_info"
        if [[ "$gen_num" == "$week_backup_gen" ]]; then
            backup_date=$(date -d "@$timestamp" +"$backup_date_format" 2>/dev/null || \
                         date -d "$date_str" +"$backup_date_format" 2>/dev/null || \
                         echo "$date_str")
            existing_backups["$gen_num"]="BACKUP-$backup_date"
            if [[ "$DRY_RUN" == "true" ]]; then
                log_dry_run "Would mark generation $gen_num as backup: BACKUP-$backup_date"
            else
                log_success "Marked generation $gen_num as backup: BACKUP-$backup_date"
            fi
        fi
    done
fi

if [[ -n "$day_backup_gen" ]]; then
    for gen_info in "${generations[@]}"; do
        IFS='|' read -r gen_num timestamp date_str <<< "$gen_info"
        if [[ "$gen_num" == "$day_backup_gen" ]]; then
            backup_date=$(date -d "@$timestamp" +"$backup_date_format" 2>/dev/null || \
                         date -d "$date_str" +"$backup_date_format" 2>/dev/null || \
                         echo "$date_str")
            existing_backups["$gen_num"]="BACKUP-$backup_date"
            if [[ "$DRY_RUN" == "true" ]]; then
                log_dry_run "Would mark generation $gen_num as backup: BACKUP-$backup_date"
            else
                log_success "Marked generation $gen_num as backup: BACKUP-$backup_date"
            fi
        fi
    done
fi

# Save backup markers
if [[ "$DRY_RUN" == "true" ]]; then
    log_dry_run "Would update backup marker file: $BACKUP_MARKER_FILE"
    log_dry_run "Backups to be marked:"
    for gen_num in "${!existing_backups[@]}"; do
        echo "    - Generation $gen_num: ${existing_backups[$gen_num]}"
    done
else
    {
        for gen_num in "${!existing_backups[@]}"; do
            echo "$gen_num|${existing_backups[$gen_num]}"
        done
    } > "$BACKUP_MARKER_FILE"
fi

# Get last N generations (most recent)
last_n_gens=()
gen_count=${#generations[@]}
start_idx=$((gen_count - KEEP_LAST_N))
if [[ $start_idx -lt 0 ]]; then
    start_idx=0
fi

for ((i=start_idx; i<gen_count; i++)); do
    IFS='|' read -r gen_num timestamp date_str <<< "${generations[$i]}"
    last_n_gens+=("$gen_num")
done

log_info "Keeping last $KEEP_LAST_N generation(s): ${last_n_gens[*]}"

# Collect all generations to keep
declare -A keep_gens
for gen in "${last_n_gens[@]}"; do
    keep_gens["$gen"]=1
done
for gen in "${!existing_backups[@]}"; do
    keep_gens["$gen"]=1
done

# Find generations to delete
gens_to_delete=()
for gen_info in "${generations[@]}"; do
    IFS='|' read -r gen_num timestamp date_str <<< "$gen_info"
    if [[ -z "${keep_gens[$gen_num]:-}" ]]; then
        gens_to_delete+=("$gen_num")
    fi
done

# Delete unwanted generations
if [[ ${#gens_to_delete[@]} -gt 0 ]]; then
    if [[ "$DRY_RUN" == "true" ]]; then
        log_dry_run "Would delete ${#gens_to_delete[@]} generation(s): ${gens_to_delete[*]}"
    else
        log_info "Deleting ${#gens_to_delete[@]} generation(s): ${gens_to_delete[*]}"
        for gen in "${gens_to_delete[@]}"; do
            nix-env --delete-generations "$gen" --profile "$PROFILE" || log_warn "Failed to delete generation $gen"
        done
        log_success "Deleted unwanted generations"
    fi
else
    log_info "No generations to delete"
fi

# Check total count and remove oldest backups if needed
remaining_gens=($(nix-env --list-generations --profile "$PROFILE" | awk 'NR > 1 {print $1}' | sort -n))
total_count=${#remaining_gens[@]}

if [[ $total_count -gt $MAX_TOTAL_GENERATIONS ]]; then
    log_warn "Total generations ($total_count) exceeds maximum ($MAX_TOTAL_GENERATIONS)"
    log_info "Removing oldest backups to maintain limit..."
    
    # Sort backups by generation number (oldest first)
    backup_list=()
    for gen in "${remaining_gens[@]}"; do
        if [[ -n "${existing_backups[$gen]:-}" ]]; then
            backup_list+=("$gen")
        fi
    done
    
    # Remove oldest backups until we're under the limit
    excess=$((total_count - MAX_TOTAL_GENERATIONS))
    removed=0
    for gen in "${backup_list[@]}"; do
        if [[ $removed -lt $excess ]]; then
            # Don't delete if it's in the last N generations
            if [[ ! " ${last_n_gens[@]} " =~ " ${gen} " ]]; then
                if [[ "$DRY_RUN" == "true" ]]; then
                    log_dry_run "Would remove old backup generation: $gen (${existing_backups[$gen]})"
                    ((removed++))
                else
                    log_info "Removing old backup generation: $gen (${existing_backups[$gen]})"
                    nix-env --delete-generations "$gen" --profile "$PROFILE" || log_warn "Failed to delete generation $gen"
                    unset existing_backups["$gen"]
                    ((removed++))
                fi
            fi
        fi
    done
    
    # Update backup marker file
    if [[ "$DRY_RUN" != "true" ]]; then
        {
            for gen_num in "${!existing_backups[@]}"; do
                echo "$gen_num|${existing_backups[$gen_num]}"
            done
        } > "$BACKUP_MARKER_FILE"
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        log_dry_run "Would remove $removed old backup(s)"
    else
        log_success "Removed $removed old backup(s)"
    fi
fi

# Final summary
final_gens=($(nix-env --list-generations --profile "$PROFILE" | awk 'NR > 1 {print $1}' | sort -n))
log_success "Generation management complete!"
log_info "Current generations: ${final_gens[*]}"
log_info "Backups marked:"
for gen in "${final_gens[@]}"; do
    if [[ -n "${existing_backups[$gen]:-}" ]]; then
        echo "  - Generation $gen: ${existing_backups[$gen]}"
    fi
done

# Instructions for GRUB naming (optional)
if [[ -n "$week_backup_gen" || -n "$day_backup_gen" ]]; then
    echo ""
    log_info "To show backup names in GRUB menu, temporarily set in configuration.nix:"
    if [[ -n "$week_backup_gen" ]]; then
        for gen_info in "${generations[@]}"; do
            IFS='|' read -r gen_num timestamp date_str <<< "$gen_info"
            if [[ "$gen_num" == "$week_backup_gen" ]]; then
                backup_date=$(date -d "@$timestamp" +"$backup_date_format" 2>/dev/null || \
                             date -d "$date_str" +"$backup_date_format" 2>/dev/null || \
                             echo "$date_str")
                echo "  boot.loader.grub.configurationName = \"BACKUP-$backup_date\";"
            fi
        done
    fi
    echo "  Then rebuild and remove the line for the next generation."
fi

