from django.db import models
class Employee(models.Model):
 name = models.CharField(max_length=100)
 employee_id=models.CharField(max_length=20)
 first_name=models.CharField(max_length=50)
 last_name=models.CharField(max_length=50)
 email=models.EmailField()
 department=models.CharField(max_length=50)
 designation=models.CharField(max_length=50)
 salary=models.DecimalField(max_digits=10,decimal_places=2)
 def __str__(self): return self.first_name
  def test():
    pass
  
