module OrganizationFetcher
  private

  def fetch_organization
    @organization = Organization.find_by(id: session['devise.organization_id'])

    unless @organization
      redirect_to new_organization_url, alert: 'Create a new organization'
    end
  end
end
