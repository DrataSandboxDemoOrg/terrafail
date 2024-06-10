# ---------------------------------------------------------------------
# Big Query
# ---------------------------------------------------------------------
resource "google_bigquery_dataset" "TerraFailBigQuery_dataset" {
  dataset_id = "TerraFailBigQuery_dataset"
  location   = "US-EAST1"
  project    = "terrafail"

  access {
    special_group = "allUseres"
  }
}

resource "google_bigquery_dataset_iam_binding" "TerraFailBigQuery_iam_binding" {
  dataset_id = google_bigquery_dataset.TerraFailBigQuery_dataset.dataset_id
  role       = "roles/bigquery.dataViewer"
  members = [
    # Drata: Explicitly scope [google_bigquery_dataset_iam_binding.members] in adherence with the principal of least privilege. Avoid the use of overly permissive allow-all access patterns such as ([allusers, allauthenticatedusers])
    "allUsers",
  ]
}

resource "google_bigquery_dataset_iam_member" "TerraFailBigQuery_iam_member" {
  dataset_id = google_bigquery_dataset.TerraFailBigQuery_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "allUsers"
  # Drata: Explicitly scope [google_bigquery_dataset_iam_member.member] in adherence with the principal of least privilege. Avoid the use of overly permissive allow-all access patterns such as ([allusers, allauthenticatedusers])
}

resource "google_bigquery_table" "TerraFailBigQuery_table" {
  # Drata: Set [configId] to ensure that organization-wide label conventions are followed.
  dataset_id = google_bigquery_dataset.TerraFailBigQuery_dataset.dataset_id
  table_id   = "bigQ"
  time_partitioning {
    type = "DAY"
  }
}

resource "google_bigquery_table_iam_binding" "TerraFailBigQuery_table_iam_binding" {
  dataset_id = google_bigquery_table.TerraFailBigQuery_table.dataset_id
  table_id   = google_bigquery_table.TerraFailBigQuery_table.table_id
  role       = "roles/bigquery.dataOwner"
  members = [
    # Drata: Explicitly scope [google_bigquery_table_iam_binding.members] in adherence with the principal of least privilege. Avoid the use of overly permissive allow-all access patterns such as ([allusers, allauthenticatedusers])
    "allUsers",
  ]
}

resource "google_bigquery_table_iam_member" "TerraFailBigQuery_table_iam_member" {
  dataset_id = google_bigquery_table.TerraFailBigQuery_table.dataset_id
  table_id   = google_bigquery_table.TerraFailBigQuery_table.table_id
  role       = "roles/bigquery.dataOwner"
  member     = "allUsers"
  # Drata: Explicitly scope [google_bigquery_table_iam_member.member] in adherence with the principal of least privilege. Avoid the use of overly permissive allow-all access patterns such as ([allusers, allauthenticatedusers])
}
