📄 Invoicing App

The Invoicing App is a Flutter-based application that allows you to store details in a table, generate professional PDF invoices, and fully customize invoice details through simple settings.

<img width="1896" height="985" alt="capture1" src="https://github.com/user-attachments/assets/0dfedf5d-cbd8-4f6d-9ebb-46e2b63a17fa" />
<img width="1890" height="986" alt="capture2" src="https://github.com/user-attachments/assets/e284358f-3493-476e-a8d3-aa6015a57cc2" />
<img width="803" height="827" alt="capture3" src="https://github.com/user-attachments/assets/aca95451-ed19-4f74-a13c-9668a0e0d9d1" />


🚀 Features

Settings-Based Customization

Update profile information (name, address, contact details, etc.).

Configure invoice coordinates and preferences directly from the settings page.

All updates are automatically applied to generated invoices.

Invoice Generation

Generate professional PDF invoices instantly.

Include stored details from the table and user-defined settings.

Dynamic PDF Layout

Profile and settings updates are reflected in invoice design.

Flexible layout that can adapt to your business branding.

🛠️ Tech Stack

Framework: Flutter

State Management: Riverpod

Database & Persistence: Drift
 (SQLite ORM for Flutter)
 
📂 Architecture: Clean Architecture

Database Layer – persistent storage with Drift

Repositories – business logic abstraction

Models – domain entities and data structures

Presentation – UI built with Flutter & Riverpod

📂 Project Structure

lib/

  │── database/         # Drift database setup and DAOs

  │── repositories/     # Repositories for data access

  │── models/           # Domain models & entities

  │── presentation/     # Flutter UI with Riverpod state management

  │── main.dart         # App entry point
