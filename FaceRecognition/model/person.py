class Person:

    def __init__(self, personId, firstName, lastName, folder):
        self.personId = personId
        self.fistName = firstName
        self.lastName = lastName
        self.folder = folder

    def __str__(self):
        return 'Person({}, {}, {}, {})'.format(self.personId, self.fistName, self.lastName, self.folder)