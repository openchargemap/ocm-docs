
select Country, Connection1_Type, COUNT(Connection1_Type) as NumConnections  from ViewAllEquipment WHERE SubmissionStatus IN ('Submission Published','Imported and Published')
GROUP BY Country, Connection1_Type
ORDER BY Country, COUNT(Connection1_Type) DESC
