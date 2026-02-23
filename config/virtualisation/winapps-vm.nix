# Declarative WinApps Windows VM for libvirt
# Creates the RDPWindows VM used by WinApps - see docs/libvirt.md
#
# === REQUIRED ===
# 1. Download Windows 10/11 Pro ISO: https://www.microsoft.com/software-download
# 2. Download VirtIO drivers ISO: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso
# 3. Set windowsIso and virtioIso paths below
#
# === USAGE ===
# - Rebuild: nixos-rebuild switch
# - Boot VM with Windows ISO, install Windows, load VirtIO drivers during install
# - Enable RDP, run oem/install.bat and RDPApps.reg from ~/.config/winapps/oem
# - Start VM (don't log in): virsh start RDPWindows
# - Run: winapps-setup --user
#
{ config, lib, pkgs, ... }:
let
  cfg = config.virtualisation.winappsVm;
  vmName = cfg.vmName;
  diskPath = "/var/lib/libvirt/images/${vmName}.qcow2";
  nvramPath = "/var/lib/libvirt/qemu/nvram/${vmName}_VARS.fd";

  # OVMF paths - NixOS libvirt provides these in /run/libvirt/nix-ovmf (set by libvirtd-config)
  # Override with ovmfCodeOverride/ovmfVarsOverride if your system uses different filenames
  ovmfCode = if cfg.ovmfCodeOverride != null then cfg.ovmfCodeOverride
    else "/run/libvirt/nix-ovmf/edk2-x86_64-secure-code.fd";
  ovmfVars = if cfg.ovmfVarsOverride != null then cfg.ovmfVarsOverride
    else "/run/libvirt/nix-ovmf/edk2-i386-vars.fd";

  memoryKiB = cfg.memory * 1024;

  domainXml = pkgs.writeText "winapps-domain.xml" ''
    <domain type='kvm'>
      <name>${vmName}</name>
      <memory unit='KiB'>${toString memoryKiB}</memory>
      <currentMemory unit='KiB'>${toString memoryKiB}</currentMemory>
      <vcpu placement='static'>${toString cfg.vcpus}</vcpu>
      <os firmware='efi'>
        <type arch='x86_64' machine='pc-q35-10.1'>hvm</type>
        <firmware>
          <feature enabled='no' name='enrolled-keys'/>
          <feature enabled='yes' name='secure-boot'/>
        </firmware>
        <loader readonly='yes' secure='yes' type='pflash' format='raw'>${ovmfCode}</loader>
        <nvram template='${ovmfVars}' templateFormat='raw' format='raw'>${nvramPath}</nvram>
        <boot dev='hd'/>
      </os>
      <features>
        <acpi/>
        <apic/>
        <hyperv mode='custom'>
          <relaxed state='on'/>
          <vapic state='on'/>
          <spinlocks state='on' retries='8191'/>
          <vpindex state='on'/>
          <runtime state='on'/>
          <synic state='on'/>
          <stimer state='on'>
            <direct state='on'/>
          </stimer>
          <reset state='on'/>
          <frequencies state='on'/>
          <tlbflush state='on'/>
          <ipi state='on'/>
          <avic state='on'/>
        </hyperv>
        <vmport state='off'/>
        <smm state='on'/>
      </features>
      <cpu mode='host-passthrough' check='none' migratable='on'/>
      <clock offset='localtime'>
        <timer name='rtc' present='no' tickpolicy='catchup'/>
        <timer name='pit' present='no' tickpolicy='delay'/>
        <timer name='hpet' present='no'/>
        <timer name='kvmclock' present='no'/>
        <timer name='hypervclock' present='yes'/>
      </clock>
      <on_poweroff>destroy</on_poweroff>
      <on_reboot>restart</on_reboot>
      <on_crash>destroy</on_crash>
      <pm>
        <suspend-to-mem enabled='no'/>
        <suspend-to-disk enabled='no'/>
      </pm>
      <devices>
        <emulator>/run/libvirt/nix-emulators/qemu-system-x86_64</emulator>
        <disk type='file' device='disk'>
          <driver name='qemu' type='qcow2' discard='unmap'/>
          <source file='${diskPath}'/>
          <target dev='vda' bus='virtio'/>
        </disk>
        <disk type='file' device='cdrom'>
          <driver name='qemu' type='raw'/>
          <source file='${cfg.windowsIso}'/>
          <target dev='sdb' bus='sata'/>
          <readonly/>
        </disk>
        <disk type='file' device='cdrom'>
          <driver name='qemu' type='raw'/>
          <source file='${cfg.virtioIso}'/>
          <target dev='sdc' bus='sata'/>
          <readonly/>
        </disk>
        <controller type='usb' index='0' model='qemu-xhci' ports='15'/>
        <controller type='pci' index='0' model='pcie-root'/>
        <controller type='pci' index='1' model='pcie-root-port'>
          <model name='pcie-root-port'/>
          <target chassis='1' port='0x10'/>
        </controller>
        <controller type='pci' index='2' model='pcie-root-port'>
          <model name='pcie-root-port'/>
          <target chassis='2' port='0x11'/>
        </controller>
        <controller type='sata' index='0'/>
        <controller type='virtio-serial' index='0'/>
        <interface type='network'>
          <source network='default'/>
          <model type='virtio'/>
        </interface>
        <channel type='unix'>
          <target type='virtio' name='org.qemu.guest_agent.0'/>
        </channel>
        <serial type='pty'>
          <target type='isa-serial' port='0'>
            <model name='isa-serial'/>
          </target>
        </serial>
        <console type='pty'>
          <target type='serial' port='0'/>
        </console>
        <input type='tablet' bus='usb'/>
        <input type='mouse' bus='ps2'/>
        <input type='keyboard' bus='ps2'/>
        <graphics type='spice' autoport='yes'>
          <listen type='address'/>
          <image compression='off'/>
        </graphics>
        <sound model='ich9'/>
        <audio id='1' type='spice'/>
        <video>
          <model type='qxl' ram='65536' vram='65536' vgamem='16384' heads='1' primary='yes'/>
        </video>
        <memballoon model='virtio'/>
      </devices>
    </domain>
  '';

  defineScript = pkgs.writeShellScript "winapps-vm-define" ''
    set -e
    mkdir -p /var/lib/libvirt/images /var/lib/libvirt/qemu/nvram

    # Ensure default network is active (required for VM networking)
    if ! virsh net-info default 2>/dev/null | grep -q "Active:.*yes"; then
      echo "Starting libvirt default network..."
      virsh net-start default
      virsh net-autostart default
    fi

    # Create disk if it doesn't exist
    if [ ! -f "${diskPath}" ]; then
      echo "Creating disk image ${diskPath} (${toString cfg.diskSizeG}G)..."
      ${config.virtualisation.libvirtd.qemu.package}/bin/qemu-img create -f qcow2 "${diskPath}" ${toString cfg.diskSizeG}G
      chown qemu-libvirtd:qemu-libvirtd "${diskPath}" 2>/dev/null || true
    fi

    # Define domain only if it does not already exist
    if virsh list --all --name | grep -qx "${vmName}"; then
      echo "Domain ${vmName} already exists, skipping define."
    else
      echo "Creating VM ${vmName}..."
      virsh define ${domainXml}
      echo "VM ${vmName} ready."
    fi
    echo "Start with: virsh start ${vmName}"
  '';
in
{
  options.virtualisation.winappsVm = {
    enable = lib.mkEnableOption "declarative WinApps Windows VM";

    vmName = lib.mkOption {
      type = lib.types.str;
      default = "RDPWindows";
      description = "VM name (must match winapps.conf VM_NAME)";
    };

    memory = lib.mkOption {
      type = lib.types.int;
      default = 4096;
      description = "RAM in MiB";
    };

    vcpus = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "Number of virtual CPUs";
    };

    diskSizeG = lib.mkOption {
      type = lib.types.int;
      default = 64;
      description = "Disk size in GB";
    };

    windowsIso = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "/var/lib/libvirt/images/Win11_23H2_English_x64v2.iso";
      description = "Path to Windows 10/11 Pro ISO";
    };

    virtioIso = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "/var/lib/libvirt/images/virtio-win.iso";
      description = "Path to VirtIO drivers ISO";
    };

    ovmfCodeOverride = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Override OVMF code path if auto-detect fails";
    };

    ovmfVarsOverride = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Override OVMF vars path if auto-detect fails";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      # Export for virsh, virt-manager, WinApps (all user sessions)
      environment.variables.LIBVIRT_DEFAULT_URI = "qemu:///system";

      assertions = [
        {
          assertion = cfg.windowsIso != "";
          message = "winappsVm: Set windowsIso path (Windows 10/11 Pro ISO). Download from https://www.microsoft.com/software-download";
        }
        {
          assertion = cfg.virtioIso != "";
          message = "winappsVm: Set virtioIso path. Download from https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso";
        }
      ];
    }
    (lib.mkIf (cfg.windowsIso != "" && cfg.virtioIso != "" && config.virtualisation.libvirtd.enable) {
      systemd.services.winapps-vm-define = {
        description = "Define WinApps Windows VM in libvirt";
        after = [ "libvirtd.service" "libvirtd-config.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "oneshot";
        path = [ config.virtualisation.libvirtd.package config.virtualisation.libvirtd.qemu.package ];
        environment.LIBVIRT_DEFAULT_URI = "qemu:///system";
        script = "${defineScript}";
      };
    })
  ]);
}
