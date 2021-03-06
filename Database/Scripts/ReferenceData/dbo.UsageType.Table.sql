SET IDENTITY_INSERT [dbo].[UsageType] ON 

INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (0, N'(Unknown)', NULL, NULL, NULL, NULL)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (1, N'Public', NULL, NULL, NULL, 1)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (2, N'Private - Restricted Access', NULL, 1, NULL, 0)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (3, N'Privately Owned - Notice Required', NULL, NULL, NULL, 0)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (4, N'Public - Membership Required', 0, 1, 1, 1)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (5, N'Public - Pay At Location', 1, 0, 0, 1)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (6, N'Private - For Staff, Visitors or Customers', 0, 0, 0, 0)
INSERT [dbo].[UsageType] ([ID], [Title], [IsPayAtLocation], [IsMembershipRequired], [IsAccessKeyRequired], [IsPublicAccess]) VALUES (7, N'Public - Notice Required', 0, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[UsageType] OFF
