"""
django command to wait for the db to be available
"""

from django.core.management.base import BaseCommand

import time

from psycopg2 import OperationalError as Psycops2Error

from django.db.utils import OperationalError

class Command(BaseCommand):
    "django command to wait for db"
    
    def handle(self, *args, **kwargs):
        self.stdout.write("waiting for database")
        db_up = False
        
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycops2Error, OperationalError):
                self.stdout.write("database not available waiting 1 second..")
                time.sleep(1)
        
        self.stdout.write(self.style.SUCCESS("database available"))