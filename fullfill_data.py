import math
from datetime import datetime, timedelta
import faker
from random import randint
import sqlite3

from create_db import create_db


NUMBER_STUDENTS = 30
NUMBER_GROUPS = 3
DISCIPLINES = ['Математика', 'Філософія', 'Фізика', 'Хімія', 'Історія']
NUMBER_TEACHERS = 3
NUMBER_GRADES = 20


def get_date_of() -> datetime:
    # диапазон для обучения
    start = datetime(2022, 9, 1)
    finish = datetime(2022, 10, 30)

    delta = (finish - start).days
    day = None
    weekday = 5
    while weekday in [5, 6]:
        day = start + timedelta(randint(0, delta))
        weekday = day.weekday()
    return day


def insert_data_to_db() -> None:

    fake = faker.Faker('uk-UA')

    # Создадим соединение с нашей БД и получим объект курсора для манипуляций с данными
    with sqlite3.connect('homework08.db') as con:

        cur = con.cursor()

        """ заполняем таблицу групп """

        sql_to_groups = """INSERT INTO groups(name)
                               VALUES (?)"""

        for _ in range(NUMBER_GROUPS):
            cur.execute(sql_to_groups, (fake.bothify(text='???-##', letters='ABCDE'), ))

        """ заполняем таблицу преподавателей """

        sql_to_teachers = """INSERT INTO teachers(fullname)
                               VALUES (?)"""

        for _ in range(NUMBER_TEACHERS):
            cur.execute(sql_to_teachers, (fake.name(), ))

        """ заполняем таблицу дисциплин """

        sql_to_disciplines = """INSERT INTO disciplines(teacher_id, name)
                               VALUES (?,?)"""

        for number, discipline in enumerate(DISCIPLINES):
            cur.execute(sql_to_disciplines, (math.floor(number / len(DISCIPLINES) * NUMBER_TEACHERS) + 1, discipline, ))


        """ заполняем таблицу студентов равномерно в каждую группу"""

        sql_to_students = """INSERT INTO students(group_id, fullname)
                               VALUES (?,?)"""

        for number in range(NUMBER_STUDENTS):
            cur.execute(sql_to_students, (math.floor(number / NUMBER_STUDENTS * NUMBER_GROUPS) + 1, fake.name(), ))

        # Последней заполняем таблицу с оценками

        sql_to_grades = """INSERT INTO grades(discipline_id, student_id, date_of, grade)
                               VALUES (?,?,?,?)"""

        for student in range(NUMBER_STUDENTS):
            for _ in range(NUMBER_GRADES):
                cur.execute(sql_to_grades, (randint(1, len(DISCIPLINES)), student + 1, get_date_of(), randint(6, 12)))

        # Фиксируем наши изменения в БД

        con.commit()


if __name__ == "__main__":
    create_db()
    insert_data_to_db()

