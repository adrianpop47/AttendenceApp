import unittest

from backend.tests import database_repository_test, user_validator_test, service_test

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromModule(database_repository_test)
    unittest.TextTestRunner(verbosity=2).run(suite)
    suite = unittest.TestLoader().loadTestsFromModule(user_validator_test)
    unittest.TextTestRunner(verbosity=2).run(suite)
    suite = unittest.TestLoader().loadTestsFromModule(service_test)
    unittest.TextTestRunner(verbosity=2).run(suite)
