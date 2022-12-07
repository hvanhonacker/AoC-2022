require "minitest/autorun"

require_relative 'disk_manager'

class DiskManagerTest < Minitest::Test
  def test_that_sum_of_folder_caped_at_100_000_is_correct
    res = DiskManager.new(File.read('input-test.txt').split(/\n/)).sum_of_folders(max_size: 100_000)
    assert_equal 95437, res
  end

  def test_size_of_the_dir_to_delete
    res = DiskManager.new(File.read('input-test.txt').split(/\n/)).size_of_the_dir_to_delete

    assert_equal 24933642, res
  end

  def test_easy
    commands = <<~CMDS
      $ cd /
      $ ls
      1 root.log
      dir a
      $ cd a
      $ ls
      dir aa
      10 a.txt
      $ cd aa
      $ ls
      100 aa.txt
      dir aaa
      $ cd aaa
      $ ls
      1000 aaa.txt
    CMDS

    res = DiskManager.new(commands.split(/\n/)).sum_of_folders(max_size: 100_000)

    assert_equal 1111 + 1110 + 1100 + 1000, res
  end


  def test_nav_patterns
    assert_match DiskManager::MOVE_IN, '$ cd a'
    refute_match DiskManager::MOVE_IN, '$ cd ..'
    refute_match DiskManager::MOVE_IN, '$ cd /'
    assert_equal 'a', '$ cd a'.match(DiskManager::MOVE_IN)[:dir_name]

    assert_match DiskManager::MOVE_OUT, '$ cd ..'
    refute_match DiskManager::MOVE_OUT, '$ cd a'
    refute_match DiskManager::MOVE_OUT, '$ cd /'

    assert_match DiskManager::MOVE_TO_ROOT, '$ cd /'
    refute_match DiskManager::MOVE_TO_ROOT, '$ cd a'
    refute_match DiskManager::MOVE_TO_ROOT, '$ cd ..'

    assert_match DiskManager::LIST, '$ ls'

    assert_match DiskManager::FILE, '123456 azerty.ext'
    assert_equal 'azerty.ext', '123456 azerty.ext'.match(DiskManager::FILE)[:file_name]
    assert_equal '123456', '123456 azerty.ext'.match(DiskManager::FILE)[:file_size]

    assert_match DiskManager::DIR, 'dir azerty'
    assert_equal 'azerty', 'dir azerty'.match(DiskManager::DIR)[:dir_name]
  end
end
