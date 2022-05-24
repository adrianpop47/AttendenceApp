# Server config
import logging
import sys

IP = "192.168.0.101"
PORT = 4000

# Database config:
DATABASE_DIALECT = "mysql"
DATABASE_DRIVER = "pymysql"
DATABASE_USERNAME = "root"
DATABASE_PASSWORD = "admin"
DATABASE_HOST = "localhost"
DATABASE_PORT = "3307"
DATABASE_NAME = "attendance_app"
DATABASE_CONNECTION_STRING = "{0}+{1}://{2}:{3}@{4}:{5}/{6}".format(DATABASE_DIALECT,
                                                                    DATABASE_DRIVER,
                                                                    DATABASE_USERNAME,
                                                                    DATABASE_PASSWORD,
                                                                    DATABASE_HOST,
                                                                    DATABASE_PORT,
                                                                    DATABASE_NAME)

# Logger config:
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler("debug.log"),
        logging.StreamHandler(sys.stdout)
    ]
)
