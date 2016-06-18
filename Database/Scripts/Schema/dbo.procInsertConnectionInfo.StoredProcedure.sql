USE [OCM_Live]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[procInsertConnectionInfo]
    (
      @ChargePointID INT ,
      @Connection_TypeID INT ,
      @Connection_LevelID INT = NULL ,
      @Connection_Amps INT = NULL ,
      @Connection_Voltage INT = NULL ,
      @Connection_Quantity INT = NULL ,
      @Reference NVARCHAR(100) = NULL ,
      @StatusTypeID INT = NULL
    )
AS 
    BEGIN
        IF (@Connection_TypeID IS NOT NULL AND @Connection_TypeID!=0)
            OR @Connection_LevelID IS NOT NULL
            OR @Connection_Amps IS NOT NULL
            OR @Connection_Voltage IS NOT NULL
            OR @Connection_Quantity IS NOT NULL 
            BEGIN
                IF @Connection_TypeID IS NULL 
                    SET @Connection_TypeID = 0
		
                IF NOT EXISTS ( SELECT  1
                                FROM    dbo.ConnectionInfo
                                WHERE   ChargePointID = @ChargePointID
                                        AND Reference = @Reference
                                        AND ConnectionTypeID = @Connection_TypeID
                                        AND LevelTypeID = @Connection_LevelID ) 
                    BEGIN
						
						PRINT 'Creating Connection:'+CONVERT(VARCHAR,@Connection_LevelID)
						--create connection info record
                        INSERT  INTO ConnectionInfo
                                ( ChargePointID ,
                                  ConnectionTypeID ,
                                  Reference ,
                                  StatusTypeID ,
                                  Amps ,
                                  Voltage ,
                                  LevelTypeID ,
                                  Quantity
		                    )
                        VALUES  ( @ChargePointID ,
                                  @Connection_TypeID ,
                                  @Reference ,
                                  @StatusTypeID ,
                                  @Connection_Amps ,
                                  @Connection_Voltage ,
                                  @Connection_LevelID , --chargerlevelid
                                  @Connection_Quantity 
		                    )
                    END
            END
		
		--create charger info record (deprecated)
        IF @Connection_LevelID IS NOT NULL
            AND NOT EXISTS ( SELECT 1
                             FROM   dbo.ChargerInfo
                             WHERE  ChargePointID = @ChargePointID
                                    AND ChargerTypeID = @Connection_LevelID ) 
            BEGIN
                INSERT  INTO ChargerInfo
                        ( ChargePointID ,
                          ChargerTypeID
                        )
                VALUES  ( @ChargePointID ,
                          @Connection_LevelID
                        )
            END
    END

GO
