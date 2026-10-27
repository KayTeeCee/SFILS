import os
import mysql.connector 

def run_app():
    db_host = os.getenv("DB_HOST", "localhost")
    db_user = os.getenv("DB_USER", "root")
    db_pass = os.getenv("DB_PASSWORD", "password123")
    db_name = os.getenv("DB_NAME", "SF_library")

    try:
        db = mysql.connector.connect(
            host = db_host,
            user = db_user,
            password = db_pass,
            database = db_name
        )
        cursor = db.cursor()
    except mysql.connector.Error as err:
        print(f"Database could not connect: {err}")
        return

    while True:
        print("\nMain Menu")
        print("1. View Library Stats by Age Range")
        print("2. Update Library Information")
        print("3. Exit Application")

        choice = input("\nEnter your choice (1-3): ")

        if choice == '1':
            print("\nAvailable Age Ranges: ")
            print("-0 to 9 years -10 to 19 years -20 to 24 years")
            print("-25 to 34 years -35 to 44 years -45 to 54 years")
            print("-55 to 59 years -60 to 64 years -65 to 74 years")
            print("-75 years and over")

            target_age = input("\nType the age range to search: ")

            query = """
                SELECT p.age_range, COUNT(*), SUM(f.checkout_total), SUM(f.renewal_total)
                FROM patron_activity f
                JOIN patrons p ON f.patron_id = p.patron_id
                WHERE p.age_range = %s
                GROUP BY p.age_range;
            """

            try: 
                cursor.execute(query, (target_age,))
                result = cursor.fetchone()

                if result:
                    print(f"Age Group:     {result[0]}")
                    print(f"Active Record:     {result[1]}")
                    print(f"Total Checkouts:     {int(result[2])}")
                    print(f"Total Renewals:     {int(result[3])}")
                else:
                    print("\nNo data found for that input.")
            except mysql.connector.Error as err:
                print(f"Error getting statistics: {err}")

        elif choice == '2':
            patron_input = input("\nEnter the Patron ID to update: ").strip()
            if not patron_input or not patron_input.isdigit():
                print("Error: Invalid Patron ID. Please try again with an appropriate numeric value.")
                continue

            print("\nNotification Choices: email, phone, print, none")
            user_choice = input("Enter new choice: ").strip().lower()

            if user_choice == 'email':
                code_val = 'z'
                has_email_val = True
            elif user_choice == 'phone':
                code_val = 'p'
                has_email_val = False
            elif user_choice == 'print':
                code_val = 'a'
                has_email_val = False
            elif user_choice == 'none':
                code_val = '-'
                has_email_val = False
            else:
                print("Error: Invalid choice. Please choose email, phone, print, or none.")
                continue

            update_query = """
                UPDATE patrons
                SET notice_medium_code = %s,
                    has_email = %s
                WHERE patron_id = %s;
            """

            try:
                cursor.execute(update_query, (code_val, has_email_val, int(patron_input)))
                db.commit()

                if cursor.rowcount > 0:
                    print(f"Update successful! Set preferences to '{user_choice}' (Code: '{code_val}') for Patron ID {patron_input}.")
                else: 
                    print("\nPatron ID not found in database records.")
            except mysql.connector.Error as err:
                print(f"Error updating database: {err}")

        elif choice == '3':
            print("\nShutting down SFILS application interface.")
            break
        else: 
            print("\nInvalid menu choice. Please select 1, 2, or 3.")

    cursor.close()
    db.close()

if __name__ == "__main__":
    run_app()
