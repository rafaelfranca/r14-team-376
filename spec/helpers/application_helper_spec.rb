require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#avatar' do
    it 'returns the avatar image tag if it is present' do
      expect(helper.avatar('http://avatar.com/imagem.jpg', alt: 'alt')).to eq(
        '<img alt="alt" title="alt" src="http://avatar.com/imagem.jpg?s=128" width="64" height="64" />'
      )
    end

    it 'returns a placeholder avatar if it is not present' do
      expect(helper.avatar(nil, alt: 'alt')).to eq(
        '<img alt="alt" title="alt" src="http://placehold.it/128x128" width="64" height="64" />'
      )
    end

    it 'accepts size' do
      expect(helper.avatar('http://avatar.com/imagem.jpg', alt: 'alt', size: '48')).to eq(
        '<img alt="alt" title="alt" src="http://avatar.com/imagem.jpg?s=96" width="48" height="48" />'
      )
    end

    it 'requests the avatar with double of size' do
      expect(helper.avatar('http://avatar.com/imagem.jpg', alt: 'alt', size: '100')).to eq(
        '<img alt="alt" title="alt" src="http://avatar.com/imagem.jpg?s=200" width="100" height="100" />'
      )
    end

    it 'appends the parameter in the URL in the right way' do
      expect(helper.avatar('http://avatar.com/imagem.jpg?c=1', alt: 'alt', size: '100')).to eq(
        '<img alt="alt" title="alt" src="http://avatar.com/imagem.jpg?c=1&amp;s=200" width="100" height="100" />'
      )
    end

    it 'accepts arbritaries options' do
      expect(helper.avatar('http://avatar.com/imagem.jpg?c=1', alt: 'alt', size: '100', class: 'foo')).to eq(
        '<img alt="alt" title="alt" class="foo" src="http://avatar.com/imagem.jpg?c=1&amp;s=200" width="100" height="100" />'
      )
    end
  end
end
