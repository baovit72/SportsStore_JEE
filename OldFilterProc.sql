USE SportsStoreJEE
GO
/****** Object:  StoredProcedure [dbo].[NhaCungUng_Filter]    Script Date: 15-Jun-20 12:20:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Lọc nhà cung ứng
select * from Product
ORDER BY Id
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

alter PROC USP_FilterProduct
	@offset int null,
	@limit int null,
	@name nvarchar(256) NULL,
	@brand nvarchar(256) NULL,
	@category nvarchar(256) NULL,
	@stock int null
AS
BEGIN
if (@offset!=0 and @limit!=0)
	SELECT * FROM [dbo].Product
	WHERE 
	(@name is null or @name = '' or Name like '%' + @name + '%') and
	(@brand is null or @brand = '' or Brand like '%' + @brand + '%') and
	(@category is null or @category = '' or Category like '%' + @category + '%') and
	(@stock is null or @stock =0 or Stock = @stock)
	ORDER BY Id
	OFFSET @offset ROWS
	FETCH NEXT @limit ROWS ONLY
	else
		SELECT * FROM [dbo].Product
	WHERE 
	(@name is null or @name = '' or Name like '%' + @name + '%') and
	(@brand is null or @brand = '' or Brand like '%' + @brand + '%') and
	(@category is null or @category = '' or Category like '%' + @category + '%') and
	(@stock is null or @stock=0 or Stock = @stock)
END

EXEC USP_FilterProduct @offset=5, @limit=5 @category=N'Ghế'


