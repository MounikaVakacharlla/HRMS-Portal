from django.db import models


class Employee(models.Model):
    name = models.CharField(max_length=100)
    age = models.IntegerField()


def test():
    pass
