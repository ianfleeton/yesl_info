module OrganisationsHelper
  def cache_key_for_organisations
    count          = Organisation.count
    max_updated_at = Organisation.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "organisations/all-#{count}-#{max_updated_at}"
  end
end
