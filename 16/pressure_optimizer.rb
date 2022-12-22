class PressureOptimizer
  def self.parse(file)
    rates= {}
    cnxs = {}

    File.read(file).split(/\n/).each do |line|
      valve, rate, cnx = line.scan(/Valve (.{2}) has flow rate=(\d+); tunnels? leads? to valves? (.+)/).first
      valve = valve.to_sym
      rate = rate.to_i
      cnx = cnx.split(', ').map(&:to_sym)

      rates[valve] = rate
      cnxs[valve] = cnx
    end

    new(cnxs, rates)
  end

  def initialize(cnxs, rates)
    @cnxs = cnxs
    @rates = rates
    @times = {}
  end

  def optimal_release(start: :AA, time: 30, max_valves_count: 8)
    max = 0
    best_path = nil

    candidates = non_zero_valves.reject { |v| v == start }

    candidates.permutation(max_valves_count).each do |path|
      released, path = total_release(path.prepend(start), time)

      if released > max
        max = released
        best_path = path

        puts best_path.join ', '
        puts max
      end
    end

    puts best_path.join ', '
    puts max

    max
  end

  private

  def non_zero_valves
    @non_zero_valves ||= @rates.select { |_vl, r| r > 0 }.keys
  end

  def total_release(path, ttl)
    total_press_rlsd = 0
    current_rate = 0
    actual_path = [path.first]

    path.each_cons(2) do |start, dest|
      if (t = time_to_reach_and_open(start, dest)) < ttl
        actual_path << dest
        ttl -= t
        total_press_rlsd += t * current_rate
        current_rate += @rates[dest]
      else
        break
      end
    end

    [total_press_rlsd += ttl * current_rate, actual_path]
  end

  def time_to_reach_and_open(start, dest)
    key = [start, dest].sort
    time = @times[key]

    return time if time

    if start != dest
      dist = 1
      cur_nds = [start]
      explored = []

      while !cur_nds.detect { |nd| @cnxs[nd].include?(dest) }
        explored += cur_nds
        cur_nds = cur_nds.map { |nd| @cnxs[nd] }.flatten - explored
        dist += 1
      end
    else
      dist = 0
    end

    @times[key] = dist + TIME_TO_OPEN
  end

  TIME_TO_OPEN = 1
end
