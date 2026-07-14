CREATE TYPE user_status AS ENUM ('Active', 'Inactive', 'Banned');
CREATE TYPE movie_status AS ENUM ('Coming Soon', 'Now Showing', 'Ended');
CREATE TYPE hall_type AS ENUM ('2D', '3D', 'IMAX', '4DX');
CREATE TYPE seat_type AS ENUM ('Standard', 'VIP', 'Couple');
CREATE TYPE showtime_status AS ENUM ('Scheduled', 'Ongoing', 'Completed', 'Cancelled');
CREATE TYPE booking_status AS ENUM ('Pending', 'Confirmed', 'Cancelled', 'Refunded');
CREATE TYPE discount_type AS ENUM ('Percentage', 'Fixed Amount');
CREATE TYPE payment_method AS ENUM ('Credit Card', 'Momo', 'ZaloPay', 'Cash');
CREATE TYPE payment_status AS ENUM ('Pending', 'Success', 'Failed', 'Refunded');
CREATE TYPE notif_type AS ENUM ('System', 'Promotion', 'Booking');
CREATE TYPE seat_booking_status AS ENUM ('Available', 'Reserved', 'Booked');

CREATE TABLE Roles (
    RoleID SERIAL PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255)
);

CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    RoleID INT NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20) UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    AvatarURL VARCHAR(255),
    Status user_status DEFAULT 'Active',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_role FOREIGN KEY(RoleID) REFERENCES Roles(RoleID)
);

CREATE TABLE UserRoles (
    UserID INT,
    RoleID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(UserID, RoleID),
    FOREIGN KEY(UserID) REFERENCES Users(UserID),
    FOREIGN KEY(RoleID) REFERENCES Roles(RoleID)
);

CREATE TABLE Movies (
    MovieID SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT,
    DurationMinutes INT NOT NULL,
    ReleaseDate DATE NOT NULL,
    Language VARCHAR(50),
    Director VARCHAR(100),
    MovieCast TEXT,
    PosterURL VARCHAR(255),
    TrailerURL VARCHAR(255),
    Status movie_status DEFAULT 'Coming Soon',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Genres (
    GenreID SERIAL PRIMARY KEY,
    Name VARCHAR(100) UNIQUE NOT NULL,
    Description TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Movie_Genres (
    MovieID INT,
    GenreID INT,
    PRIMARY KEY(MovieID, GenreID),
    FOREIGN KEY(MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY(GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Cinemas (
    CinemaID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Halls (
    HallID SERIAL PRIMARY KEY,
    CinemaID INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Type hall_type DEFAULT '2D',
    Capacity INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(CinemaID) REFERENCES Cinemas(CinemaID)
);

CREATE TABLE Seats (
    SeatID SERIAL PRIMARY KEY,
    HallID INT NOT NULL,
    SeatRow VARCHAR(5) NOT NULL,
    Number INT NOT NULL,
    Type seat_type DEFAULT 'Standard',
    PriceMultiplier DECIMAL(3,2) DEFAULT 1.00,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(HallID, SeatRow, Number),
    FOREIGN KEY(HallID) REFERENCES Halls(HallID)
);

CREATE TABLE Showtimes (
    ShowtimeID SERIAL PRIMARY KEY,
    MovieID INT NOT NULL,
    HallID INT NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    BasePrice DECIMAL(10,2) NOT NULL,
    Status showtime_status DEFAULT 'Scheduled',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY(HallID) REFERENCES Halls(HallID)
);

CREATE TABLE Showtime_Seats (
    ShowtimeSeatID SERIAL PRIMARY KEY,
    ShowtimeID INT NOT NULL,
    SeatID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Status seat_booking_status DEFAULT 'Pending', -- Có thể điều chỉnh enum này nếu cần
    UNIQUE(ShowtimeID, SeatID),
    FOREIGN KEY(ShowtimeID) REFERENCES Showtimes(ShowtimeID),
    FOREIGN KEY(SeatID) REFERENCES Seats(SeatID)
);

CREATE TABLE Coupons (
    CouponID SERIAL PRIMARY KEY,
    Code VARCHAR(50) UNIQUE NOT NULL,
    DiscountType discount_type NOT NULL,
    DiscountValue DECIMAL(10,2) NOT NULL,
    ExpiryDate TIMESTAMP NOT NULL,
    UsageLimit INT DEFAULT 100,
    UsageCount INT DEFAULT 0,
    IsActive BOOLEAN DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Bookings (
    BookingID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    ShowtimeID INT NOT NULL,
    CouponID INT NULL,
    BookingDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status booking_status DEFAULT 'Pending',
    TotalAmount DECIMAL(10,2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(UserID) REFERENCES Users(UserID),
    FOREIGN KEY(ShowtimeID) REFERENCES Showtimes(ShowtimeID),
    FOREIGN KEY(CouponID) REFERENCES Coupons(CouponID)
);

CREATE TABLE Tickets (
    TicketID SERIAL PRIMARY KEY,
    BookingID INT NOT NULL,
    ShowtimeSeatID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY(ShowtimeSeatID) REFERENCES Showtime_Seats(ShowtimeSeatID)
);

CREATE TABLE Payments (
    PaymentID SERIAL PRIMARY KEY,
    BookingID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod payment_method NOT NULL,
    Status payment_status DEFAULT 'Pending',
    TransactionID VARCHAR(100),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(BookingID) REFERENCES Bookings(BookingID)
);

CREATE TABLE Reviews (
    ReviewID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    MovieID INT NOT NULL,
    Rating SMALLINT NOT NULL,
    Comment TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(UserID) REFERENCES Users(UserID),
    FOREIGN KEY(MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE Notifications (
    NotificationID SERIAL PRIMARY KEY,
    UserID INT NOT NULL,
    Type notif_type NOT NULL,
    Content TEXT NOT NULL,
    IsRead BOOLEAN DEFAULT FALSE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(UserID) REFERENCES Users(UserID)
);