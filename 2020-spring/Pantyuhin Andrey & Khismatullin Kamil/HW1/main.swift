var oak: Tree<Int> = Tree<Int>()

oak.add(value: 20)
oak.add(value: 25)
oak.add(value: 22)
oak.add(value: 28)
oak.add(value: 26)
oak.add(value: 27)
oak.add(value: 32)
oak.add(value: 15)
oak.add(value: 17)
oak.add(value: 13)
oak.add(value: 19)
oak.add(value: 18)

oak.printValues()
print()
print("deleating:")

oak.delete(value: 15)

oak.printValues()

oak.find(value: 21)

