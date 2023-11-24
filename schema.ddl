-- Drop existing schema and create a new one
DROP SCHEMA IF EXISTS recording CASCADE;
CREATE SCHEMA recording;
SET search_path TO recording;

-- Studio Table
-- Represents a recording studio with a unique ID, name, address, and a manager.
CREATE TABLE Studio (
    studio_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    manager_id INTEGER,
    FOREIGN KEY (manager_id) REFERENCES Person(person_id) ON UPDATE CASCADE
    -- Assumption: A studio has only one current manager. Historical manager data is not tracked.
);

-- Person Table
-- Represents an individual with a unique ID, name, email, phone number, and optional engineer certification.
CREATE TABLE Person (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    is_engineer BOOLEAN NOT NULL DEFAULT FALSE,
    certification TEXT
    -- Assumption: 'certification' field stores multiple certifications as a single text, not structured data.
);

-- Session Table
-- Represents a recording session with a unique ID, associated studio, engineer, start and end times, and a session fee.
CREATE TABLE Session (
    session_id SERIAL PRIMARY KEY,
    studio_id INTEGER NOT NULL,
    engineer_id INTEGER,
    session_start TIMESTAMP NOT NULL,
    session_end TIMESTAMP NOT NULL,
    session_fee FLOAT NOT NULL,
    FOREIGN KEY (studio_id) REFERENCES Studio(studio_id) ON DELETE CASCADE,
    FOREIGN KEY (engineer_id) REFERENCES Person(person_id) ON DELETE SET NULL,
    UNIQUE (studio_id, session_start)
    -- Constraint: Sessions in the same studio cannot start at the same time.
);

-- Band Table
-- Represents a musical band with a unique ID and name.
CREATE TABLE Band (
    band_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
    -- Assumption: A band's name is its unique identifier.
);

-- BandMember Table
-- Represents the many-to-many relationship between Bands and Persons.
CREATE TABLE BandMember (
    band_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    PRIMARY KEY (band_id, person_id),
    FOREIGN KEY (band_id) REFERENCES Band(band_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE
);

-- Participation Table
-- Represents who played in a session, linking Sessions to Persons.
CREATE TABLE Participation (
    session_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    PRIMARY KEY (session_id, person_id),
    FOREIGN KEY (session_id) REFERENCES Session(session_id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE
);

-- RecordingSegment Table
-- Represents a segment of sound recording with a unique ID, length, and format.
CREATE TABLE RecordingSegment (
    segment_id SERIAL PRIMARY KEY,
    session_id INTEGER NOT NULL,
    length_seconds INT NOT NULL,
    format VARCHAR(50) NOT NULL,
    FOREIGN KEY (session_id) REFERENCES Session(session_id) ON DELETE CASCADE
);

-- Track Table
-- Represents a music track with a unique ID and name.
CREATE TABLE Track (
    track_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Album Table
-- Represents a music album with a unique ID, name, and release date.
CREATE TABLE Album (
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL
);

-- TrackAlbumAssociation Table
-- Represents the many-to-many relationship between Tracks and Albums.
CREATE TABLE TrackAlbumAssociation (
    track_id INTEGER NOT NULL,
    album_id INTEGER NOT NULL,
    PRIMARY KEY (track_id, album_id),
    FOREIGN KEY (track_id) REFERENCES Track(track_id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES Album(album_id) ON DELETE CASCADE
);

-- SegmentTrackAssociation Table
-- Represents the many-to-many relationship between RecordingSegments and Tracks.
CREATE TABLE SegmentTrackAssociation (
    segment_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    PRIMARY KEY (segment_id, track_id),
    FOREIGN KEY (segment_id) REFERENCES RecordingSegment(segment_id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES Track(track_id) ON DELETE CASCADE
);