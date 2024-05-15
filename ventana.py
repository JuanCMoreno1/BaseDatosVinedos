import tkinter as tk
import viniedos

def create_main_window():
    root = tk.Tk()
    root.title("Inicio de Sesión")

    label_choice = tk.Label(root, text="Seleccione una opción:")
    label_choice.pack()

    radio_client = tk.Radiobutton(root, text="Cliente", value="client", command=viniedos.client_selected)
    radio_client.pack()

    radio_admin = tk.Radiobutton(root, text="Administrador", value="admin", command=viniedos.admin_selected)
    radio_admin.pack()

    root.mainloop()