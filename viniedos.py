import tkinter as tk
from tkinter import messagebox
import pymysql

def connect_to_db():
    db = pymysql.connect(host="localhost", port=3307, user="", password="", db="mibasevh")
    return db

def verify_credentials(username, password):
    db = connect_to_db()
    cursor = db.cursor()

    query = "SELECT * FROM trabajadores WHERE Nombre = %s AND contrasenia = %s"
    cursor.execute(query, (username, password))
    result = cursor.fetchone()

    db.close()

    return result is not None

def admin_selected():
    def show_table_options():
        table_options_window = tk.Toplevel(root)
        table_options_window.title("Seleccionar Tabla")

        for table_name in ["clientes1", "climasuelo", "costosfinanzas", "equiposmaquinaria", "produccionvino", "trabajadores", "uvas", "uvasviniedo", "ventasdistribucion", "viniedos"]:
            table_button = tk.Button(table_options_window, text=table_name, command=lambda t=table_name: show_crud_options(t))
            table_button.pack()

    def show_crud_options(table_name):
        crud_options_window = tk.Toplevel(root)
        crud_options_window.title(f"Operaciones CRUD para {table_name}")

        def open_create_window():
            create_entry_window(table_name)

        create_button = tk.Button(crud_options_window, text="Crear", command=open_create_window)
        create_button.pack()

        def open_read_window():
            read_entries(table_name)

        read_button = tk.Button(crud_options_window, text="Leer", command=open_read_window)
        read_button.pack()

        def open_update_window():
            update_entry_window(table_name)

        update_button = tk.Button(crud_options_window, text="Actualizar", command=open_update_window)
        update_button.pack()

        def open_delete_window():
            delete_entry_window(table_name)

        delete_button = tk.Button(crud_options_window, text="Eliminar", command=open_delete_window)
        delete_button.pack()


    def create_entry_window(table_name):
        create_window = tk.Toplevel(root)
        create_window.title(f"Crear Entrada en {table_name}")

        db = connect_to_db()
        cursor = db.cursor()

        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = [column[0] for column in cursor.fetchall()]

        entry_widgets = {}
        for column in columns:
            label = tk.Label(create_window, text=column)
            label.grid(row=columns.index(column), column=0, padx=5, pady=5)
            entry = tk.Entry(create_window)
            entry.grid(row=columns.index(column), column=1, padx=5, pady=5)
            entry_widgets[column] = entry

        def create_entry(table_name, data):
            db = connect_to_db()
            cursor = db.cursor()

            # Crear la entrada en la tabla
            placeholders = ", ".join(["%s"] * len(data))
            columns = ", ".join(data.keys())
            values = tuple(data.values())

            query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
            cursor.execute(query, values)

            db.commit()
            db.close()


        def create_new_entry():
            data = {column: entry.get() for column, entry in entry_widgets.items()}
            create_entry(table_name, data)  # Llama a la función de creación de entrada
            messagebox.showinfo("Crear Entrada", "Entrada creada exitosamente.")
            create_window.destroy()

        create_button = tk.Button(create_window, text="Crear", command=create_new_entry)
        create_button.grid(row=len(columns), columnspan=2, padx=5, pady=5)

    def read_entries(table_name):
        read_window = tk.Toplevel(root)
        read_window.title(f"Leer Entradas de {table_name}")

        db = connect_to_db()
        cursor = db.cursor()

        cursor.execute(f"SELECT * FROM {table_name}")
        entries = cursor.fetchall()

        for i, entry in enumerate(entries):
            for j, value in enumerate(entry):
                label = tk.Label(read_window, text=value)
                label.grid(row=i, column=j, padx=5, pady=5)

    def update_entry_window(table_name):
        update_window = tk.Toplevel(root)
        update_window.title(f"Actualizar Entrada en {table_name}")

        def update_entry():
            id = entry_id.get()
            data = {column: entry.get() for column, entry in entry_widgets.items()}
            update_entry(table_name, id, data)
            messagebox.showinfo("Actualizar Entrada", "Entrada actualizada exitosamente.")
            update_window.destroy()

        label_id = tk.Label(update_window, text="ID:")
        label_id.grid(row=0, column=0, padx=5, pady=5)
        entry_id = tk.Entry(update_window)
        entry_id.grid(row=0, column=1, padx=5, pady=5)

        db = connect_to_db()
        cursor = db.cursor()

        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = [column[0] for column in cursor.fetchall()]

        entry_widgets = {}
        for column in columns:
            label = tk.Label(update_window, text=column)
            label.grid(row=columns.index(column) + 1, column=0, padx=5, pady=5)
            entry = tk.Entry(update_window)
            entry.grid(row=columns.index(column) + 1, column=1, padx=5, pady=5)
            entry_widgets[column] = entry

        update_button = tk.Button(update_window, text="Actualizar", command=update_entry)
        update_button.grid(row=len(columns) + 1, columnspan=2, padx=5, pady=5)

    def delete_entry_window(table_name):
        delete_window = tk.Toplevel(root)
        delete_window.title(f"Eliminar Entrada en {table_name}")

        def delete_entry():
            id = entry_id.get()
            delete_entry(table_name, id)
            messagebox.showinfo("Eliminar Entrada", "Entrada eliminada exitosamente.")
            delete_window.destroy()

        label_id = tk.Label(delete_window, text="ID:")
        label_id.grid(row=0, column=0, padx=5, pady=5)
        entry_id = tk.Entry(delete_window)
        entry_id.grid(row=0, column=1, padx=5, pady=5)

        delete_button = tk.Button(delete_window, text="Eliminar", command=delete_entry)
        delete_button.grid(row=1, columnspan=2, padx=5, pady=5)

    admin_window = tk.Toplevel(root)
    admin_window.title("Inicio de Sesión - Administrador")

    label_username = tk.Label(admin_window, text="Nombre de Usuario:")
    label_username.pack()
    entry_username = tk.Entry(admin_window)
    entry_username.pack()

    label_password = tk.Label(admin_window, text="Contraseña:")
    label_password.pack()
    entry_password = tk.Entry(admin_window, show="*")
    entry_password.pack()

    def login():
        username = entry_username.get()
        password = entry_password.get()

        if verify_credentials(username, password):
            messagebox.showinfo("Inicio de Sesión Exitoso", "¡Bienvenido, Administrador!")
            admin_window.destroy()
            show_table_options()
        else:
            messagebox.showerror("Inicio de Sesión Fallido", "Nombre de usuario o contraseña incorrectos")

    button_login = tk.Button(admin_window, text="Iniciar Sesión", command=login)
    button_login.pack()

def client_selected():
    def fetch_data_from_table(table_name, info_frame):
        for widget in info_frame.winfo_children():
            widget.destroy()

        db = connect_to_db()
        cursor = db.cursor()

        # Obtener los nombres de las columnas
        cursor.execute(f"SHOW COLUMNS FROM {table_name}")
        columns = [column[0] for column in cursor.fetchall()]

        # Mostrar los nombres de las columnas
        label_columns = tk.Label(info_frame, text=" | ".join(columns))
        label_columns.pack()

        # Obtener y mostrar los datos de la tabla
        query = f"SELECT * FROM {table_name}"
        cursor.execute(query)
        result = cursor.fetchall()

        for row in result:
            label = tk.Label(info_frame, text=str(row))
            label.pack()

        db.close()

    client_window = tk.Toplevel(root)
    client_window.title("Seleccionar Tabla - Cliente")

    tables = ["clientes1", "climasuelo", "costosfinanzas", "equiposmaquinaria", "produccionvino", "uvas", "uvasviniedo", "ventasdistribucion", "viniedos"]

    for table_name in tables:
        button_fetch_data = tk.Button(client_window, text=f"Ver {table_name}", command=lambda t=table_name: fetch_data_from_table(t, info_frame))
        button_fetch_data.pack()

    info_frame = tk.Frame(client_window)
    info_frame.pack()

root = tk.Tk()
root.title("Sistema de Administración")

radio_admin = tk.Radiobutton(root, text="Administrador", value="admin", command=admin_selected)
radio_admin.pack()

radio_client = tk.Radiobutton(root, text="Cliente", value="client", command=client_selected)
radio_client.pack()

root.mainloop()