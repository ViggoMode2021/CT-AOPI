from django.db import models
import csv

class School(models.Model):
    school = models.CharField(max_length=30)
    town = models.CharField(max_length=50)
    county = models.CharField(max_length=30)
    superintendent = models.CharField(max_length=50)
    superintendent_email = models.CharField(max_length=30)
    technology_coordinator = models.CharField(max_length=50)
    technology_coordinator_email = models.CharField(max_length=50)

    def __str__(self):
        return self.school + ' ' + self.town + ' ' + self.county + ' ' + self.superintendent + ' ' + self.superintendent_email + ' ' + self.technology_coordinator + ' ' + self.technology_coordinator_email

class all_schools(models.Model):
    def get_all_schools(self):
        schools = []
        with open('C:/Users/ryans/pythonProject6/django-api/schools.csv', 'r', encoding='utf-8-sig') as fp:
            # You can also put the relative path of csv file
            # with respect to the manage.py file
            reader1 = csv.reader(fp, delimiter=',')
            for school in reader1:
                schools.append(school)
        return schools
