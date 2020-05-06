import csv

import cx_Oracle

connection = cx_Oracle.connect("kolobaieva", "kolobaieva", "xe")

cursor_profile = connection.cursor()

cursor_profile.execute("""
SELECT
    TRIM(profile_id) as profile_id,
    TRIM(profile_username) as profile_username,
    TRIM(profile_info) as profile_info,
    TRIM(profile_watched) as profile_watched
FROM profiles""")

for profile_id, profile_username, profile_info, profile_watched in cursor_profile:

    with open("profile_" + profile_id + ".csv", "w") as file:
        writer = csv.writer(file)

        writer.writerow(["Id", profile_id])
        writer.writerow(["Username", profile_username])
        writer.writerow(["Info", profile_info])
        writer.writerow(["Watched", profile_watched])

        cursor_movies = connection.cursor()

        query = """
                    SELECT
                        DISTINCT movie_id,
                        movie_name,
                        movie_description,
                        movie_rating
                    FROM
                        movies NATURAL JOIN 
                        (SELECT movie_id_fk
                        FROM watched_movies NATURAL JOIN
                        profiles
                        WHERE :id = profile_id_fk)
                    WHERE movie_id_fk = movie_id"""

        cursor_movies.execute(query, id = profile_id)
        writer.writerow([])
        writer.writerow(["movie id", "movie_name", "movie_description", "movie_rating"])
        for order_row in cursor_movies:
            writer.writerow(order_row)

cursor_profile.close()