# Host-specific style configuration for stardust
# This configuration is passed to all imported modules via extraSpecialArgs as 'style'

# script to read the installed fonts names: 
# fc-list --format="%{family[0]}\t%{style[0]}\t%{file}\n" | awk -F'\t' 'BEGIN {OFS="\t"} (tolower($2) ~ /regular|normal|book|roman/ || $2 == "") { n=split($3,a,"/"); $3=a[n]; print }' | sort -f | column -ts \t

{
  # Global font configuration - Noto Mono Nerd Font
  nerdFont = "NotoMono Nerd Font";
}

