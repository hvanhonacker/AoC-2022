require_relative "disk_manager"

p DiskManager.new(File.read('input.txt').split(/\n/)).sum_of_folders(max_size: 100_000)
# 1770595
