# frozen_string_literal: true

module Users
  module Organizations
    module Create
      class AffiliateCampaigns < Actor 
        input :organization, type: Organization

        def call
          AffiliateCampaign.create!(
            organization_id: organization.id,
            title: 'Crie sua Primeira Campanha de Indicação 👋',
            subtitle: 'Ganhe 20 R$ por indicação',
            description: 'Preencha o formulário e já receba o seu código e link personalizado.',
            title_form: "Bem-vindo ao #{organization.title}",
            subtitle_form: 'Gerar seu código',
            rule_title: 'Regras',
            rule_description: 'O valor é enviado 20 dias após a confirmação do pagamento do cliente.',
            background_color: 'yellow',
            primary_color: 'info',
            secondary_color: 'dark'
          )
        end
      end
    end
  end
end
