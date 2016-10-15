require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test 'product price must be positive' do
    product = Product.new(title: "New book", description: 'xyz', image_url: 'abc.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "product is not valid without unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
                          description: 'yyy',
                          price: 1,
                          image_url: 'freed.gif')

    assert product.invalid?
    assert_equal [I18.translate('errors.messages.taken')], product.errors[:title]
  end


end
