select * from ViewAllLocations
where IsLive=1
order by latitude,longitude

select count(*),Town,StateOrProvince,Country from ViewAllLocations
where IsLive=1
group by Town,StateOrProvince,Country
having count(*)>1
order by Country,StateOrProvince, Town

select count(*),StateOrProvince,Country from ViewAllLocations
where IsLive=1
group by StateOrProvince,Country
having count(*)>1
order by Country,StateOrProvince