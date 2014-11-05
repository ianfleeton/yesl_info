module DomainsHelper
  def cache_key_for_domains
    count          = Domain.count
    max_updated_at = Domain.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "domains/all-#{count}-#{max_updated_at}"
  end
end
