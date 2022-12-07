require_relative "disk_manager"

disk_manager = DiskManager.new(File.read('input.txt').split(/\n/))
p disk_manager.sum_of_folders(max_size: 100_000)
# 1770595

p disk_manager.size_of_the_dir_to_delete
# 2195372
