require 'byebug'

class DiskManager
  attr_reader :commands, :cur_dir

  def initialize(commands)
    @commands = commands
  end

  def sum_of_folders(max_size: 100_000)
    root_dir = build_directory_structure

    # root_dir.print

    root_dir.sizes.select {|size| size <= max_size }.sum
  end

  def build_directory_structure
    @root_dir, @cur_dir = nil

    commands.each do |cmd|
      case cmd
      when MOVE_OUT
        move_out
      when MOVE_TO_ROOT
        move_to_root
      when MOVE_IN
        move_in($~[:dir_name])
      when LIST
        # Nothing
      when FILE
        file($~[:file_name], $~[:file_size].to_i)
      when DIR
        # Nothing
      else
        raise "unknown cmd #{cmd}"
      end
    end

    @root_dir
  end

  def move_to_root
    @root_dir ||=  Dir.new("/")
    @cur_dir = @root_dir
  end

  def move_in(dir)
    @cur_dir = @cur_dir.cd(dir)
  end

  def move_out
    @cur_dir = @cur_dir.parent
  end

  def file(name, size)
    @cur_dir.file(name, size)
  end

  MOVE_TO_ROOT  = /\$ cd \//
  MOVE_IN       = /\$ cd (?<dir_name>\w+)/
  MOVE_OUT      = /\$ cd \.\./
  LIST          = /\$ ls/
  FILE          = /(?<file_size>\d+) (?<file_name>.+$)/
  DIR           = /dir (?<dir_name>.+)/
end

class Dir
  def initialize(name, parent = nil)
    @name = name
    @parent = parent
    @files_sizes = {}
    @children = []
  end

  attr_reader :name, :files_sizes, :children, :parent

  def file(file, size)
    @files_sizes[file] = size
  end

  def cd(dir_name)
    @children.detect {|child| child.name == dir_name } ||
      self.class.new(dir_name, self).tap { |child| @children << child }
  end

  def sizes
    children_sizes = children.map(&:sizes)
    direct_children_sizes = children_sizes.map(&:first)

    [own_files_size + direct_children_sizes.sum] + children_sizes.flatten
  end

  def own_files_size
    files_sizes.values.sum
  end

  def print(indent="")
    puts "#{indent}- #{name} (dir)"

    children.each { _1.print(indent + "  ")}

    files_sizes.each do |name, size|
      puts "#{indent + "  "}- #{name} (file, size=#{size})"
    end
  end
end
