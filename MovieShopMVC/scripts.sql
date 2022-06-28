IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616202109_IntitialMigration')
BEGIN
    CREATE TABLE [Genres] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Genres] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616202109_IntitialMigration')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220616202109_IntitialMigration', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616210520_UpdatingGenreTable')
BEGIN
    ALTER TABLE [Genres] DROP CONSTRAINT [PK_Genres];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616210520_UpdatingGenreTable')
BEGIN
    EXEC sp_rename N'[Genres]', N'Genre';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616210520_UpdatingGenreTable')
BEGIN
    DECLARE @var0 sysname;
    SELECT @var0 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Genre]') AND [c].[name] = N'Name');
    IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Genre] DROP CONSTRAINT [' + @var0 + '];');
    ALTER TABLE [Genre] ALTER COLUMN [Name] nvarchar(64) NOT NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616210520_UpdatingGenreTable')
BEGIN
    ALTER TABLE [Genre] ADD CONSTRAINT [PK_Genre] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616210520_UpdatingGenreTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220616210520_UpdatingGenreTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616211842_CreatingMovieTable')
BEGIN
    CREATE TABLE [Movie] (
        [Id] int NOT NULL IDENTITY,
        [Title] nvarchar(256) NULL,
        [Overview] nvarchar(max) NULL,
        [Tagline] nvarchar(512) NULL,
        [Budget] decimal(18,4) NULL DEFAULT 9.9,
        [Revenue] decimal(18,4) NULL DEFAULT 9.9,
        [ImdbUrl] nvarchar(2084) NULL,
        [TmdbUrl] nvarchar(2084) NULL,
        [PosterUrl] nvarchar(2084) NULL,
        [BackdropUrl] nvarchar(2084) NULL,
        [OriginalLanguage] nvarchar(64) NULL,
        [ReleaseDate] datetime2 NULL,
        [RunTime] int NULL,
        [Price] decimal(5,2) NULL DEFAULT 9.9,
        [CreatedDate] datetime2 NULL DEFAULT (getdate()),
        [UpdatedDate] datetime2 NULL,
        [UpdatedBy] nvarchar(max) NULL,
        [CreatedBy] nvarchar(max) NULL,
        CONSTRAINT [PK_Movie] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616211842_CreatingMovieTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220616211842_CreatingMovieTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616212712_CreatingMovieGenreTable')
BEGIN
    CREATE TABLE [MovieGenre] (
        [MovieId] int NOT NULL,
        [GenreId] int NOT NULL,
        CONSTRAINT [PK_MovieGenre] PRIMARY KEY ([MovieId], [GenreId]),
        CONSTRAINT [FK_MovieGenre_Genre_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [Genre] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_MovieGenre_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616212712_CreatingMovieGenreTable')
BEGIN
    CREATE INDEX [IX_MovieGenre_GenreId] ON [MovieGenre] ([GenreId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616212712_CreatingMovieGenreTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220616212712_CreatingMovieGenreTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616213340_CreatingTrailerTable')
BEGIN
    CREATE TABLE [Trailer] (
        [Id] int NOT NULL IDENTITY,
        [MovieId] int NOT NULL,
        [TrailerUrl] nvarchar(2084) NOT NULL,
        [Name] nvarchar(2084) NOT NULL,
        CONSTRAINT [PK_Trailer] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Trailer_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616213340_CreatingTrailerTable')
BEGIN
    CREATE INDEX [IX_Trailer_MovieId] ON [Trailer] ([MovieId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220616213340_CreatingTrailerTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220616213340_CreatingTrailerTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621030142_CreatingMovieCrewTable')
BEGIN
    CREATE TABLE [MovieCrew] (
        [MovieId] int NOT NULL,
        [CrewId] int NOT NULL,
        [Department] nvarchar(450) NOT NULL,
        [Job] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_MovieCrew] PRIMARY KEY ([MovieId], [CrewId], [Department], [Job])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621030142_CreatingMovieCrewTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621030142_CreatingMovieCrewTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621030849_CreatingCrewTable')
BEGIN
    CREATE TABLE [Crews] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Gender] nvarchar(max) NOT NULL,
        [TmdbUrl] nvarchar(max) NOT NULL,
        [ProfilePath] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Crews] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621030849_CreatingCrewTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621030849_CreatingCrewTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    ALTER TABLE [Crews] DROP CONSTRAINT [PK_Crews];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    EXEC sp_rename N'[Crews]', N'Crew';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    ALTER TABLE [Crew] ADD CONSTRAINT [PK_Crew] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    CREATE INDEX [IX_MovieCrew_CrewId] ON [MovieCrew] ([CrewId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    ALTER TABLE [MovieCrew] ADD CONSTRAINT [FK_MovieCrew_Crew_CrewId] FOREIGN KEY ([CrewId]) REFERENCES [Crew] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    ALTER TABLE [MovieCrew] ADD CONSTRAINT [FK_MovieCrew_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621032448_UpdatingMovieCrewTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621032448_UpdatingMovieCrewTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621033706_CreatingMovieCastAndCastTable')
BEGIN
    CREATE TABLE [Cast] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Gender] nvarchar(max) NOT NULL,
        [TmdbUrl] nvarchar(max) NOT NULL,
        [ProfilePath] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Cast] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621033706_CreatingMovieCastAndCastTable')
BEGIN
    CREATE TABLE [MovieCast] (
        [MovieId] int NOT NULL,
        [CastId] int NOT NULL,
        [Character] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_MovieCast] PRIMARY KEY ([MovieId], [CastId], [Character]),
        CONSTRAINT [FK_MovieCast_Cast_CastId] FOREIGN KEY ([CastId]) REFERENCES [Cast] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_MovieCast_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621033706_CreatingMovieCastAndCastTable')
BEGIN
    CREATE INDEX [IX_MovieCast_CastId] ON [MovieCast] ([CastId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621033706_CreatingMovieCastAndCastTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621033706_CreatingMovieCastAndCastTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621034248_UpdatingMovieCastTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621034248_UpdatingMovieCastTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    ALTER TABLE [MovieCast] DROP CONSTRAINT [FK_MovieCast_Cast_CastId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    ALTER TABLE [Cast] DROP CONSTRAINT [PK_Cast];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    EXEC sp_rename N'[Cast]', N'Casts';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    ALTER TABLE [Casts] ADD CONSTRAINT [PK_Casts] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    CREATE TABLE [Users] (
        [Id] int NOT NULL IDENTITY,
        [FirstName] nvarchar(max) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [DateOfBirth] datetime2 NOT NULL,
        [Email] nvarchar(max) NOT NULL,
        [HashedPassword] nvarchar(max) NOT NULL,
        [Salt] nvarchar(max) NOT NULL,
        [PhoneNumber] nvarchar(max) NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEndDate] datetime2 NOT NULL,
        [LastLoginDateTime] datetime2 NOT NULL,
        [Islocked] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    CREATE TABLE [Review] (
        [MovieId] int NOT NULL,
        [UserId] int NOT NULL,
        [Rating] decimal(18,2) NOT NULL,
        [ReviewText] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Review] PRIMARY KEY ([MovieId], [UserId]),
        CONSTRAINT [FK_Review_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Review_Users_UserId] FOREIGN KEY ([UserId]) REFERENCES [Users] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    CREATE INDEX [IX_Review_UserId] ON [Review] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    ALTER TABLE [MovieCast] ADD CONSTRAINT [FK_MovieCast_Casts_CastId] FOREIGN KEY ([CastId]) REFERENCES [Casts] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621041138_CreatingReviewAndUserTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621041138_CreatingReviewAndUserTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [MovieCast] DROP CONSTRAINT [FK_MovieCast_Casts_CastId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [Review] DROP CONSTRAINT [FK_Review_Users_UserId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [Users] DROP CONSTRAINT [PK_Users];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [Casts] DROP CONSTRAINT [PK_Casts];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    EXEC sp_rename N'[Users]', N'User';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    EXEC sp_rename N'[Casts]', N'Cast';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Review]') AND [c].[name] = N'ReviewText');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Review] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Review] ALTER COLUMN [ReviewText] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Review]') AND [c].[name] = N'Rating');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Review] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [Review] ALTER COLUMN [Rating] decimal(18,2) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [User] ADD CONSTRAINT [PK_User] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [Cast] ADD CONSTRAINT [PK_Cast] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    CREATE TABLE [Favorites] (
        [Id] int NOT NULL IDENTITY,
        [MovieId] int NOT NULL,
        [UserId] int NOT NULL,
        CONSTRAINT [PK_Favorites] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Favorites_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Favorites_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    CREATE INDEX [IX_Favorites_MovieId] ON [Favorites] ([MovieId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    CREATE INDEX [IX_Favorites_UserId] ON [Favorites] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [MovieCast] ADD CONSTRAINT [FK_MovieCast_Cast_CastId] FOREIGN KEY ([CastId]) REFERENCES [Cast] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    ALTER TABLE [Review] ADD CONSTRAINT [FK_Review_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042326_CreatingFavoriteTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621042326_CreatingFavoriteTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    ALTER TABLE [Favorites] DROP CONSTRAINT [FK_Favorites_Movie_MovieId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    ALTER TABLE [Favorites] DROP CONSTRAINT [FK_Favorites_User_UserId];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    ALTER TABLE [Favorites] DROP CONSTRAINT [PK_Favorites];
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    EXEC sp_rename N'[Favorites]', N'Favorite';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    EXEC sp_rename N'[Favorite].[IX_Favorites_UserId]', N'IX_Favorite_UserId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    EXEC sp_rename N'[Favorite].[IX_Favorites_MovieId]', N'IX_Favorite_MovieId', N'INDEX';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    ALTER TABLE [Favorite] ADD CONSTRAINT [PK_Favorite] PRIMARY KEY ([Id]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    CREATE TABLE [Purchase] (
        [Id] int NOT NULL IDENTITY,
        [UserId] int NOT NULL,
        [uniqueidentifier] uniqueidentifier NOT NULL,
        [TotalPrice] decimal(18,2) NOT NULL,
        [PurchaseDatetime] datetime2 NOT NULL,
        [MovieId] int NOT NULL,
        CONSTRAINT [PK_Purchase] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Purchase_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Purchase_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    CREATE INDEX [IX_Purchase_MovieId] ON [Purchase] ([MovieId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    CREATE INDEX [IX_Purchase_UserId] ON [Purchase] ([UserId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    ALTER TABLE [Favorite] ADD CONSTRAINT [FK_Favorite_Movie_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movie] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    ALTER TABLE [Favorite] ADD CONSTRAINT [FK_Favorite_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621042920_CreatingPurchaseTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621042920_CreatingPurchaseTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621043721_CreatingUserRoleAndRoleTable')
BEGIN
    CREATE TABLE [Role] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Role] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621043721_CreatingUserRoleAndRoleTable')
BEGIN
    CREATE TABLE [UserRole] (
        [UserId] int NOT NULL,
        [RoleId] int NOT NULL,
        CONSTRAINT [PK_UserRole] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_UserRole_Role_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Role] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_UserRole_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621043721_CreatingUserRoleAndRoleTable')
BEGIN
    CREATE INDEX [IX_UserRole_RoleId] ON [UserRole] ([RoleId]);
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621043721_CreatingUserRoleAndRoleTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621043721_CreatingUserRoleAndRoleTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'TwoFactorEnabled');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [User] ALTER COLUMN [TwoFactorEnabled] bit NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var4 sysname;
    SELECT @var4 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'Salt');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var4 + '];');
    ALTER TABLE [User] ALTER COLUMN [Salt] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var5 sysname;
    SELECT @var5 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'PhoneNumber');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var5 + '];');
    ALTER TABLE [User] ALTER COLUMN [PhoneNumber] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'LockoutEndDate');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [User] ALTER COLUMN [LockoutEndDate] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var7 sysname;
    SELECT @var7 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'LastName');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var7 + '];');
    ALTER TABLE [User] ALTER COLUMN [LastName] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var8 sysname;
    SELECT @var8 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'LastLoginDateTime');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var8 + '];');
    ALTER TABLE [User] ALTER COLUMN [LastLoginDateTime] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var9 sysname;
    SELECT @var9 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'Islocked');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var9 + '];');
    ALTER TABLE [User] ALTER COLUMN [Islocked] bit NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'HashedPassword');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [User] ALTER COLUMN [HashedPassword] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'FirstName');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [User] ALTER COLUMN [FirstName] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'Email');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [User] ALTER COLUMN [Email] nvarchar(max) NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    DECLARE @var13 sysname;
    SELECT @var13 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'DateOfBirth');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var13 + '];');
    ALTER TABLE [User] ALTER COLUMN [DateOfBirth] datetime2 NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621044754_UpdatingUserTable')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621044754_UpdatingUserTable', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621045050_CreatingUserRoleAndRoleTableAgain')
BEGIN
    DECLARE @var14 sysname;
    SELECT @var14 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[User]') AND [c].[name] = N'AccessFailedCount');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [User] DROP CONSTRAINT [' + @var14 + '];');
    ALTER TABLE [User] ALTER COLUMN [AccessFailedCount] int NULL;
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621045050_CreatingUserRoleAndRoleTableAgain')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621045050_CreatingUserRoleAndRoleTableAgain', N'6.0.6');
END;
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621052044_UpdatingPurchase')
BEGIN
    EXEC sp_rename N'[Purchase].[uniqueidentifier]', N'PurchaseNumber', N'COLUMN';
END;
GO

IF NOT EXISTS(SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20220621052044_UpdatingPurchase')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20220621052044_UpdatingPurchase', N'6.0.6');
END;
GO

COMMIT;
GO

