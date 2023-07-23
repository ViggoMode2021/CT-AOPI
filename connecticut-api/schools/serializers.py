from rest_framework import serializers
from .models import School

class SchoolSerializer(serializers.ModelSerializer):
    class Meta:
        model = School
        fields = ['school', 'town', 'county', 'superintendent', 'superintendent_email', 'technology_coordinator',
                  'technology_coordinator_email']
