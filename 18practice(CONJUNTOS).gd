extends Node
 
func _ready():
	var group:Array = ["GDscript", "Python", "JavaScript"]
	print(group)

	group.append("Java")
	print(group)

	group.push_front("C#")
	print(group)

	group.append_array(["C", "C+", "Lua"])
	print(group)

	group.remove_at(2)
	print(group)

	group.set(3, "Go")
	print(group)

	print(group.has("C#"))

	group.clear()
	print(group)

# EJERCICIO EXTRA
	var set1:Array[int] = [2, 6, 3, 7, 0, 9]
	var set2:Array[int] = [1, 6, 4, 8, 3]

	var union:Array[int] = []
	for i in set1 + set2:
		if !union.has(i):
			union.append(i)
	print(union)

	var intersection:Array[int] = []
	for i in set1 + set2:
		if (set1 + set2).count(i) > 1 and !intersection.has(i):
			intersection.append(i)
	print(intersection)

	var difference:Array[int] = []
	for i in set1:
		if !set2.has(i):
			difference.append(i)
	print(difference)

	var symmetricDifference:Array[int] = []
	for i in set1 + set2:
		if (set1 + set2).count(i) < 2:
			symmetricDifference.append(i)
	print(symmetricDifference)
