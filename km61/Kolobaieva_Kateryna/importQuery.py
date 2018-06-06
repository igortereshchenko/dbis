import csv

import cx_Oracle

connection = cx_Oracle.connect("kolobaieva", "kolobaieva", "xe")

filename = "profile_1.csv"

with open(filename) as file:
    reader = csv.reader(file)

    id = next(reader)[1]
    Username = next(reader)[1]
    Info = next(reader)[1]
    Watched = next(reader)[1]

    insert_query = "insert into profiles(profile_id, profile_username, profile_info, profile_watched) values (:Profileid, :p_Username, :p_info, :p_watched )"
    cursor_customer = connection.cursor()
    cursor_customer.execute(insert_query, Profileid=id, p_Username=Username, p_info=Info, p_watched=Watched)
    cursor_customer.close()

    connection.commit()
    next(reader, None)
    next(reader, None)

    insert_query = "INSERT INTO movies(movie_id, movie_name, movie_description, movie_rating) VALUES (:movie_id, :movie_name, :movie_description, :movie_rating)"
    cursor_movies = connection.cursor()

    cursor_movies.prepare(insert_query)

    rows = []
    for row in reader:
        rows.append(row + [id])

    cursor_movies.executemany(None, rows)

    cursor_movies.close()
    connection.commit()  # save changes in db
