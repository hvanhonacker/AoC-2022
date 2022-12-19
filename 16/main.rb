
@neighbors = {}
@rates = {}

File.read("input.txt").split(/\n/).each do |line|
  v, r, n = line.scan(/Valve (.{2}) has flow rate=(\d+); tunnels? leads? to valves? (.+)/).first
  v = v.to_sym
  r = r.to_i
  n = n.split(', ').map(&:to_sym)

  @rates[v] = r
  @neighbors[v] = n
end

def xplr(vl, opened = [], total = 0, ttl = 15)
  if ttl == 0
    total
  else
    total += opened.map { @rates[_1] }.sum

    @neighbors[vl].map {  |ngh|                    xplr(ngh, opened,        total, ttl - 1) }
                  .then { |nghs_xplr| nghs_xplr << xplr(vl,  opened + [vl], total, ttl - 1) unless @rates[vl].zero? || opened.include?(vl); nghs_xplr }
                  .max
  end
end

puts @neighbors
puts @rates

puts xplr(:AA)
# ttl=15 -> ruby main.rb  13,12s user 0,06s system 99% cpu 13,217 total

# Détecter les cycles
# Backtrack qui si aucune autre option
# Réduire le graph en supprimant les noeuds nuls et ajoutant des poids aux arêtes
