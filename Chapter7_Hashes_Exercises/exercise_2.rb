#hash.merge merges two hashes and returns a new hash
#hash.merge! merges two hashes into the first hash, mutating the first hash permanently


h1 = {one: "1", two: "2"}
h2 = {three: "3", four: "4"}

h1.merge(h2)
p h1

h1.merge!(h2)
p h1
