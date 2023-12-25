from pymongo import MongoClient
from prettytable import PrettyTable
import colorama
import time

client = MongoClient("mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.1.1")
database_name = "employees"
collection_name = "employee"
db = client[database_name]
collection = db[collection_name]

colorama.init()

def add_employee():
    print(colorama.Fore.GREEN + "Adding Employee:")
    time.sleep(1)
    employee_id = input(colorama.Fore.CYAN + "Enter employee ID: ")
    name = input(colorama.Fore.CYAN + "Enter employee name: ")
    age = int(input(colorama.Fore.CYAN + "Enter employee age: "))
    position = input(colorama.Fore.CYAN + "Enter employee position: ")

    employee = {"_id": employee_id, "name": name, "age": age, "position": position}
    collection.insert_one(employee)
    print(colorama.Fore.GREEN + "Employee added successfully.\n")
    time.sleep(1)

def edit_employee():
    print(colorama.Fore.YELLOW + "Editing Employee:")
    time.sleep(1)
    employee_id = input(colorama.Fore.CYAN + "Enter the ID of the employee you want to edit: ")

    employee = collection.find_one({"_id": employee_id})
    if employee:
        print(colorama.Fore.CYAN + f"Current details: {employee}")
        time.sleep(1)
        
        new_age = int(input(colorama.Fore.CYAN + "Enter the new age (press Enter to keep it unchanged): ") or employee['age'])
        new_position = input(colorama.Fore.CYAN + "Enter the new position (press Enter to keep it unchanged): ") or employee['position']

        update_data = {"$set": {"age": new_age, "position": new_position}}
        collection.update_one({"_id": employee_id}, update_data)
        print(colorama.Fore.YELLOW + "Employee details updated successfully.\n")
        time.sleep(1)
    else:
        print(colorama.Fore.RED + f"No employee found with the ID '{employee_id}'.\n")
        time.sleep(1)

def delete_employee():
    print(colorama.Fore.RED + "Deleting Employee:")
    time.sleep(1)
    employee_id = input(colorama.Fore.CYAN + "Enter the ID of the employee you want to delete: ")

    result = collection.delete_one({"_id": employee_id})
    if result.deleted_count > 0:
        print(colorama.Fore.RED + "Employee deleted successfully.\n")
        time.sleep(1)
    else:
        print(colorama.Fore.RED + f"No employee found with the ID '{employee_id}'.\n")
        time.sleep(1)

def show_employees():
    print(colorama.Fore.CYAN + "Showing Employees:")
    time.sleep(1)
    employees = list(collection.find())
    
    if not employees:
        print(colorama.Fore.RED + "No employees found.\n")
        time.sleep(1)
    else:
        table = PrettyTable()
        table.field_names = [colorama.Fore.CYAN + "ID", colorama.Fore.CYAN + "Name", colorama.Fore.CYAN + "Age", colorama.Fore.CYAN + "Position"]
        for employee in employees:
            table.add_row([employee["_id"], employee["name"], employee["age"], employee["position"]])
        print(table)
        print()
        time.sleep(1)

while True:
    print(colorama.Fore.MAGENTA + "Employee Management System:")
    print(colorama.Fore.GREEN + "1. Add Employee")
    print(colorama.Fore.YELLOW + "2. Edit Employee Information")
    print(colorama.Fore.RED + "3. Delete Employee")
    print(colorama.Fore.CYAN + "4. Show Employees")
    print(colorama.Fore.MAGENTA + "5. Exit")

    choice = input(colorama.Fore.CYAN + "Enter your choice (1-5): ")

    if choice == "1":
        add_employee()
    elif choice == "2":
        edit_employee()
    elif choice == "3":
        delete_employee()
    elif choice == "4":
        show_employees()
    elif choice == "5":
        print(colorama.Fore.MAGENTA + "Exiting the Employee Management System. Goodbye!")
        break
    else:
        print(colorama.Fore.RED + "Invalid choice. Please enter a number between 1 and 5.\n")
    time.sleep(1)
