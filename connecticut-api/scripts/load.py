from schools.models import School
import csv

def run():
    with open('schools.csv') as file:
        reader = csv.reader(file)
        next(reader)  # Advance past the header

        School.objects.all().delete()

        for row in reader:
            print(row)

            dictionary = School(school=row[0],
                        town=row[1],
                        county=row[2],
                        superintendent=row[3],
                        superintendent_email=row[4],
                        technology_coordinator=row[5],
                        technology_coordinator_email=row[6])

            dictionary.save()
