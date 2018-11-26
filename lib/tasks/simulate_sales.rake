desc 'simulate_sales'
task simulate_sales: :environment do

  # generate Supervisors and Agents
  Team.all.each do |team|
    quantity = rand(2..5)

    user_interface = UserInterface.new(team: team, quantity: quantity, role: :supervisor, gender: nil)
    user_interface.generate_users
    puts "#{quantity} supervisors generated successfully for team #{team}"

    team.reload

    team.agents.boss.each do |supervisor|
      quantity = rand(10..50)

      user_interface = UserInterface.new(team: team, quantity: quantity, role: :agent, gender: nil, supervised_by: supervisor)
      user_interface.generate_users

      puts "-> #{quantity} agents generated successfully for supervisor #{supervisor}"
    end
  end

  Team.all.each do |team|
    puts "Sales generation for #{team} - Start process"

    team.agents.seller.limit(10).each do |agent|
      number = rand(4)
      array = (1..number).map { |n| rand(1..4) }.uniq

      Product.where(id: array).each do |product|
        product_quantity = rand(1..10)
        total = product_quantity * product.price
        saled_at = Time.zone.now - (rand(150)).days

        Sale.create!(product: product, agent: agent, quantity: product_quantity, total: total, saled_at: saled_at)
      end

      agent.reload

      puts "-> #{agent.sales.length} sales generated successfully for agent #{agent}"
    end

    puts "Sales generation for #{team} - End process"
  end

end