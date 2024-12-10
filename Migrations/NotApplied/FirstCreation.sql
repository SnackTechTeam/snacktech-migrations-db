-- -- Criação do banco de dados
-- CREATE DATABASE [SnackTechDb];
-- GO

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

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE TABLE [Pessoa] (
        [Id] uniqueidentifier NOT NULL,
        [Nome] varchar(255) NOT NULL,
        CONSTRAINT [PK_Pessoa] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE TABLE [Produto] (
        [Id] uniqueidentifier NOT NULL,
        [Categoria] int NOT NULL,
        [Nome] varchar(255) NOT NULL,
        [Descricao] varchar(1000) NOT NULL,
        [Valor] smallmoney NOT NULL,
        CONSTRAINT [PK_Produto] PRIMARY KEY ([Id])
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE TABLE [Cliente] (
        [Id] uniqueidentifier NOT NULL,
        [Email] varchar(255) NOT NULL,
        [Cpf] varchar(15) NOT NULL,
        CONSTRAINT [PK_Cliente] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Cliente_Pessoa_Id] FOREIGN KEY ([Id]) REFERENCES [Pessoa] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE TABLE [Pedido] (
        [Id] uniqueidentifier NOT NULL,
        [DataCriacao] datetime NOT NULL,
        [ClienteId] uniqueidentifier NOT NULL,
        [Status] int NOT NULL,
        CONSTRAINT [PK_Pedido] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Pedido_Cliente_ClienteId] FOREIGN KEY ([ClienteId]) REFERENCES [Cliente] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE TABLE [PedidoItem] (
        [Id] uniqueidentifier NOT NULL,
        [Quantidade] int NOT NULL,
        [Observacao] varchar(500) NOT NULL,
        [Valor] smallmoney NOT NULL,
        [ProdutoId] uniqueidentifier NOT NULL,
        [PedidoId] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_PedidoItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PedidoItem_Pedido_PedidoId] FOREIGN KEY ([PedidoId]) REFERENCES [Pedido] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_PedidoItem_Produto_ProdutoId] FOREIGN KEY ([ProdutoId]) REFERENCES [Produto] ([Id]) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Nome') AND [object_id] = OBJECT_ID(N'[Pessoa]'))
        SET IDENTITY_INSERT [Pessoa] ON;
    EXEC(N'INSERT INTO [Pessoa] ([Id], [Nome])
    VALUES (''6ee54a46-007f-4e4c-9fe8-1a13eadf7fd1'', ''Cliente Padrão'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Nome') AND [object_id] = OBJECT_ID(N'[Pessoa]'))
        SET IDENTITY_INSERT [Pessoa] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Cpf', N'Email') AND [object_id] = OBJECT_ID(N'[Cliente]'))
        SET IDENTITY_INSERT [Cliente] ON;
    EXEC(N'INSERT INTO [Cliente] ([Id], [Cpf], [Email])
    VALUES (''6ee54a46-007f-4e4c-9fe8-1a13eadf7fd1'', ''00000000191'', ''cliente.padrao@padrao.com'')');
    IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Cpf', N'Email') AND [object_id] = OBJECT_ID(N'[Cliente]'))
        SET IDENTITY_INSERT [Cliente] OFF;
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Cliente_Cpf] ON [Cliente] ([Cpf]) WHERE [Cpf] IS NOT NULL');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [IX_Cliente_Email] ON [Cliente] ([Email]) WHERE [Email] IS NOT NULL');
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE INDEX [IX_Pedido_ClienteId] ON [Pedido] ([ClienteId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE INDEX [IX_PedidoItem_PedidoId] ON [PedidoItem] ([PedidoId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    CREATE INDEX [IX_PedidoItem_ProdutoId] ON [PedidoItem] ([ProdutoId]);
END;
GO

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240809104416_FirstCreation'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240809104416_FirstCreation', N'8.0.7');
END;
GO

COMMIT;
GO

