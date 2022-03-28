class Person:

    def __init__(self, personId, name):
        self.personId = personId
        self.name = name

    def __str__(self):
        return '{}, {}'.format(self.personId, self.name)
