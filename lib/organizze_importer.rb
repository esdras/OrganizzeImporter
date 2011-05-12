require "active_support/core_ext/module/delegation"
require "ofx"

# monkey patching ofx until Nando accept my pull request.
module OFX
  module Parser
    class OFX102
      private

      def build_type(element)
        TRANSACTION_TYPES[element.search("trntype").inner_text.to_s.upcase]
      end

      def build_account
        OFX::Account.new({
          :bank_id      => html.search("bankacctfrom > bankid").inner_text,
          :id           => html.search("bankacctfrom > acctid").inner_text,
          :type         => ACCOUNT_TYPES[html.search("bankacctfrom > accttype").inner_text.to_s.upcase],
          :transactions => build_transactions,
          :balance      => build_balance,
          :currency     => html.search("bankmsgsrsv1 > stmttrnrs > stmtrs > curdef").inner_text
        })
      end

    end
  end
end

module OrganizzeImporter
  autoload :Importer, 'organizze_importer/importer'
  autoload :Parsers, 'organizze_importer/parsers'
end
