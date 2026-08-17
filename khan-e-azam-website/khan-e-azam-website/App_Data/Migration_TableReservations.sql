-- Khan-E-Azam Website — Table Reservations Migration
-- Backs the real reservation form on Reservation.aspx (previously WhatsApp/Call CTA only).
-- Safe to re-run: guarded, only applies once.
USE KhanEAzamDB;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TableReservations' AND xtype='U')
CREATE TABLE TableReservations (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(150) NOT NULL,
    ContactNumber NVARCHAR(30) NOT NULL,
    ReservationDate DATE NOT NULL,
    ReservationTime NVARCHAR(20) NOT NULL,
    PartySize INT NOT NULL,
    SpecialRequests NVARCHAR(500) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO
