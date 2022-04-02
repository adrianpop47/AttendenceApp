class Person:

    def __init__(self, id_, name):
        self.id = id_
        self.name = name

    def __str__(self):
        return '{}, {}'.format(self.id, self.name)
