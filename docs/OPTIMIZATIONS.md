# All practical macOS optimization options

The guide distinguishes **measurable energy/stability actions**, **personal preferences**, and **experimental actions with side effects**. 'Looks cleaner' is not the same as 'runs faster.'

## Priority matrix

| Setting | Proposed configuration | Expected benefit | Caution / verification |
|---|---|---|---|
| Official macOS patches | Install supported security releases | Security, bug fixes | Don't use a .0 or .1 upgrade without app checks |
| Erase All Content and Settings | Optional when rebuilding cluttered system | Removes existing user/app data | Not a new OS installation; full backup needed |
| Low Power Mode | On battery for light work | Lower system energy use | Slower sustained CPU/GPU work |
| Brightness | Comfortable minimum, often mid-range indoors | Display power reduction | No fixed universal percentage |
| Screen timeout | 3–5 min on battery if practical | Less idle display drain | Annoying if too short |
| Wake for network access | Never if no network wake use case | May reduce sleep wakes | Remote access/shares may stop responding |
| Battery charge limit | 80% for primarily plugged-in use | Reduce time held at high charge | Less unplugged runtime; occasional 100% is normal |
| Optimized charging | On | Reduces unnecessary time at full charge | Predictive charging can differ from manual cap |
| Lock versus Sleep | Close lid or Apple menu Sleep | Reduce drain when not actively working | Don't leave hot compilation in a bag |
| Login items | Disable apps you don't need at sign-in | Less persistent startup activity | VPN and sync tools may need background helpers |
| Browser tabs/extensions | Fewer heavy tabs, suspend where supported | Less CPU/memory/network use | Extension behavior and browser engine vary |
| Animated wallpapers/widgets | Disable if you dislike background motion | May reduce periodic UI work | Do not promise hours of battery saving |
| FileVault | On | Disk encryption | Recovery key must be preserved |
| Spotlight local indexing | Leave on initially | Finder search, app launcher and productivity | Indexing can temporarily use CPU |
| Time Machine | Keep backups | Reliability and recoverability | Disk snapshot cleanup needs care |
| Automatic updates | On | Patches | Test aggressive launchd changes before major update |
| Apple Intelligence | Optional off if unused | Preference, potentially model storage saved | Siri/Shortcuts/AI features lost |
| Apple telemetry opt-outs | Native privacy settings | Reduced voluntary analytics | Don't claim all telemetry stops |
| SIP | On normally | System-integrity protection | Disabling is a security downgrade |
| Gatekeeper/XProtect | On | App/malware protection | Never disable merely for performance |
| Swap | Leave managed by macOS | Stability | Disabling swap can cause app failures; not a recommended tweak |

## Security, sharing and privacy

Review in System Settings, by intent, not through a magical tweak command:

- Privacy & Security → Analytics & Improvements: opt out of optional product analytics if desired.
- Privacy & Security → Apple Advertising: opt out of personalized advertising if offered.
- Siri and Apple Intelligence: turn off features you don't use **before** using a third-party removal tool.
- General → Sharing: disable Remote Login, Remote Management, Screen Sharing and file sharing unless you use them.
- Notifications: disable noisy apps; Focus schedules reduce distraction, but this alone is not battery optimization.
- Privacy permissions: camera, microphone, accessibility, automation, Full Disk Access, screen recording, Files & Folders. Revoke unnecessary access, particularly for code agents and unknown cleanup apps.
- Avoid unsigned privileged installers and cleaners, especially with SIP disabled.

## Desktop, Finder and workflow

- Finder → View: Path Bar, Status Bar; Finder Settings: file extensions, default new Finder window, folders-first.
- Finder shortcuts: Option-Command-C copies a file's absolute path; Shift-Command-G navigates to folder.
- Dock: disable recent apps, minimize into app icon, reduce animation if you prefer. Tiny CPU savings are unproven.
- Window management: decide between Apple's app-based Command-Tab and an optional window-switching tool (e.g. AltTab). Multiple shortcut hooks can conflict.
- Trackpad: tap-to-click, secondary click, gestures, scroll direction as desired.
- Spotlight: preserve local search. Turn off unwanted **internet/suggestion** sources separately, if offered.
- Software keyboards/input sources: remove unused layouts if they complicate switching.
- Background utilities: keep only what you need; do not install a 'Mac optimizer' solely to keep it running.

## Memory and CPU

Activity Monitor > Memory: focus on memory pressure, swap used, and top heavy processes rather than targeting '0 GB used.' macOS deliberately caches files in RAM. For CPU/energy, inspect sustained high usage by browsers, media apps, Electron helpers and Node processes.

Avoid force quitting Apple daemons, running memory-purge loops, changing vm settings, deleting caches daily or disabling system services indiscriminately. A brief indexing spike after an update is expected.

## Internet and DNS

VPNs (WireGuard, sing-box, proxy engines) can require login helpers and background daemons. Disable unused providers, but do not accidentally sever traffic and assume the OS is broken. A faster DNS resolver does not guarantee meaningful laptop battery savings. Test latency and privacy/security separately.

## macOS graphics and games

Apple Silicon-native games and native Metal/Vulkan translation approaches may be smoother than Intel/Rosetta equivalents, depending on game and driver. A fanless MacBook Air will throttle during sustained GPU workloads; Low Power Mode may substantially reduce gaming performance. Thermal-pads-to-bottom-case modifications are not a recommended default.

Gaming install libraries (Steam, emulators and shader caches) are often counted as System Data. Free space by uninstalling games in their respective managers. Check game saves first.

## Storage

Inspect with du and System Settings > General > Storage; aim for a healthy free-space buffer proportional to your actual disk size, not an arbitrary claim of 100% 'SSD efficiency.' On a 256 GB machine, 40–60 GB free is a convenient working buffer for updates/builds if practical, not a hard Apple requirement. Keep backups on external drives and don't fill internal SSD with redundant game media.

## Developer machine

- Homebrew: install only formulae you use, periodically run brew cleanup after reviewing outputs, don't automate unsafe sudo deletion.
- Node/Python: audit ~/.npm, ~/.cache, Python virtual environments, build outputs and per-project node_modules. Cached packages can be rebuilt but deleting environments during active work is disruptive.
- AI CLIs and agents: inference may be remote but local indexing, scans, browser automation and long-running helper processes can keep the machine awake.
- Containers/emulators: understand which VM disk images and caches contain unique data before removal.
- Use Time Machine and Git separately; Git is not a substitute for backup of uncommitted projects or secrets.

## What popular videos often overstate

Animations, Stage Manager, Transparency, Dock effects, iCloud features, telemetry or extra daemons can be disabled for preference. A single before/after 'RAM used' screenshot is **not** scientific evidence that this improves battery life or longevity. This project separates subjective convenience, privacy choices, disk reclaim and measured power/performance.

Go to [BENCHMARKS.md](BENCHMARKS.md) before promising any gain to other users.
