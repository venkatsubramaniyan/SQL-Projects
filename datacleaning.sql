
--select the data

select * 
from  PortfolioProjects..NashvilleHousing


--standardize date format--

select convert(date,saledate) as saledate
from PortfolioProjects..NashvilleHousing


Alter table NashvilleHousing
Add SaleDateConverted date


update PortfolioProjects..NashvilleHousing
set SaleDateConverted=convert(date,saledate)

select SaleDateConverted
from PortfolioProjects..NashvilleHousing



--Populate property Address data

select PropertyAddress
from NashvilleHousing
where PropertyAddress is null


select *
from NashvilleHousing
where PropertyAddress is null
order by ParcelID





select ParcelID,count(ParcelID)
group by ParcelID
having count(ParcelID)>1 
order by count(ParcelID) desc

select ParcelID 
from NashvilleHousing 
where PropertyAddress is not null  
and  ParcelID in ( 
select ParcelID
from NashvilleHousing
where PropertyAddress is null)



 select t1.PropertyAddress,t2.PropertyAddress
 from NashvilleHousing  t1
 join NashvilleHousing  t2
 on t1.PropertyAddress is null
 and t1.ParcelID=t2.ParcelID
 and t2.PropertyAddress is not null
 
 update t1
 set t1.PropertyAddress = t2.PropertyAddress
 from NashvilleHousing  t1
 join NashvilleHousing  t2
 on t1.PropertyAddress is null
 and t1.ParcelID=t2.ParcelID
 and t2.PropertyAddress is not null
 
--Breaking out Address in to Individual columns (Address,City)

select  PropertyAddress
from NashvilleHousing


select 
    case when CHARINDEX(',',PropertyAddress)>0 
         then SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 
         else PropertyAddress end street,
    CASE WHEN CHARINDEX(',',PropertyAddress)>0 
         THEN SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))  
         ELSE NULL END as City
from NashvilleHousing

--Update Nashville 
--    case when CHARINDEX(',',PropertyAddress)>0 
--         then SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 
--         else PropertyAddress end street,
--    CASE WHEN CHARINDEX(',',PropertyAddress)>0 
--         THEN SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))  
--         ELSE NULL END as City





Alter table NashvilleHousing
Add propertysplitAddress nvarchar(255)

update PortfolioProjects..NashvilleHousing 
set propertysplitAddress= SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) 


Alter table NashvilleHousing
Add propertysplitcity nvarchar(255)

update PortfolioProjects..NashvilleHousing 
set propertysplitcity=SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))


select * 
from NashvilleHousing



select owneraddress
from NashvilleHousing


Alter table NashvilleHousing
Add ownersplitstreet nvarchar(255)


Alter table NashvilleHousing
Add ownersplitcity nvarchar(255)


Alter table NashvilleHousing
Add ownersplitstate nvarchar(255)


update PortfolioProjects..NashvilleHousing 
set ownersplitstreet=REVERSE(PARSENAME(REPLACE(REVERSE(owneraddress), ',', '.'), 1))




update PortfolioProjects..NashvilleHousing 
set ownersplitcity=REVERSE(PARSENAME(REPLACE(REVERSE(owneraddress), ',', '.'), 2))

update PortfolioProjects..NashvilleHousing 
set ownersplitstate=REVERSE(PARSENAME(REPLACE(REVERSE(owneraddress), ',', '.'), 3))


select ownersplitstreet,ownersplitcity,ownersplitstate
from NashvilleHousing


select distinct(owneraddress)
from NashvilleHousing
where ownersplitstreet is null


---change  Yes, No to Y,N in 'SolidVacant'

select distinct(SoldAsVacant)
from Nashvillehousing


SELECT CASE WHEN SoldAsVacant = 'YES' THEN 'Y' End,
case when SoldAsVacant ='No' Then 'N' end
from NashVilleHousing


select replace(SoldAsVacant,'YES','Y') 
from NashvilleHousing

update NashvilleHousing
set soldAsVacant=replace(SoldAsVacant,'YES','Y') 

update NashvilleHousing
set soldAsVacant=replace(SoldAsVacant,'No','N') 




----Remove duplicates

with rownumCTE as(
select *, 
Row_number() over (
partition by ParcelID,
             PropertyAddress,
			 Saleprice,
			 saledate,
			 legalreference
			 order by uniqueid) row_num

from NashvilleHousing
--order by ParcelID
)

select * 
from rownumCTE
where row_num >1
--order by PropertyAddress


--delete unused columns


alter table NashvilleHousing
drop column PropertyAddress,OwnerAddress,Taxdistrict

alter table NashvilleHousing
drop column saledate


select propertyAddress
from NashvilleHousing




















    







