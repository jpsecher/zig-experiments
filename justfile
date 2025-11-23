default:
  @echo "You are in {{invocation_directory()}}"
  @just --list

system-info:
  @echo "{{os_family()}} ({{os()}} on {{arch()}} with {{num_cpus()}} cores)"

test:
  @cd {{invocation_directory()}} && zig build test --summary all

watch:
  @cd {{invocation_directory()}} &&  watch --color --no-title --no-wrap zig build test --summary new --color on
