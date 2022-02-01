
# 1.

root@de-zoomcamp:~# gcloud --version
Google Cloud SDK 368.0.0
alpha 2022.01.07
beta 2022.01.07
bq 2.0.72
core 2022.01.07
gsutil 5.6
minikube 1.24.0
skaffold 1.35.1

# 2.

(base) root@de-zoomcamp:~/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform# export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/red-height-339014-4dcfbdda3016.json
(base) root@de-zoomcamp:~/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform# gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS
Activated service account credentials for: [de-zoomcamp-user@red-height-339014.iam.gserviceaccount.com]
(base) root@de-zoomcamp:~/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform# terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/google from the dependency lock file
- Using previously-installed hashicorp/google v4.7.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
(base) root@de-zoomcamp:~/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform# terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  \# google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "europe-west1"
      + project                    = "red-height-339014"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  \# google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "EUROPE-WEST1"
      + name                        = "dtc_data_lake_red-height-339014"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_storage_class = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you
run "terraform apply" now.
(base) root@de-zoomcamp:~/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform# terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  \# google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "europe-west1"
      + project                    = "red-height-339014"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  \# google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "EUROPE-WEST1"
      + name                        = "dtc_data_lake_red-height-339014"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_storage_class = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_storage_bucket.data-lake-bucket: Creation complete after 0s [id=dtc_data_lake_red-height-339014]
google_bigquery_dataset.dataset: Creation complete after 2s [id=projects/red-height-339014/datasets/trips_data_all]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
(base) root@de-zoomcamp:~/data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform#

# 3.

**53024**

select count(tpep_pickup_datetime) from yellow_taxi_data
where tpep_pickup_datetime >= '2021-01-15' and tpep_pickup_datetime < '2021-01-16';

# 4.

**2021-01-20**

select max(tip_amount) as max_tip_amount, cast(tpep_pickup_datetime as date) as pickup_date from yellow_taxi_data
where extract(month from tpep_pickup_datetime) = 1
group by pickup_date
order by max_tip_amount desc
limit 1;

# 5.

**Upper East Side North**

with zones as (
select yellow_taxi_data."PULocationID" as pulocationid_ ,yellow_taxi_data."DOLocationID" as dolocationid_, tz1.zone as engaged_zone, tz2.zone as disengaged_zone from yellow_taxi_data 
left outer join taxi_zone as tz1 on yellow_taxi_data."PULocationID" = tz1.locationid
left outer join taxi_zone as tz2 on yellow_taxi_data."DOLocationID" = tz2.locationid
) 

select disengaged_zone, count(disengaged_zone) as c from zones
where zones.engaged_zone = 'Central Park'
group by disengaged_zone
order by c desc
limit 1;

# 6. 

**Alphabet City / Unknown**

with zones as (
select yellow_taxi_data."PULocationID" as pulocationid_, yellow_taxi_data."DOLocationID" as dolocationid_, yellow_taxi_data.total_amount as total_amount_, tz1.zone as engaged_zone, tz2.zone as disengaged_zone 
from yellow_taxi_data
inner join taxi_zone as tz1 on yellow_taxi_data."PULocationID" = tz1.locationid
inner join taxi_zone as tz2 on yellow_taxi_data."DOLocationID" = tz2.locationid
)

select engaged_zone, disengaged_zone, avg(total_amount_) as avg_total_amount_ from zones
group by engaged_zone, disengaged_zone
order by avg_total_amount_ desc
limit 1;
















