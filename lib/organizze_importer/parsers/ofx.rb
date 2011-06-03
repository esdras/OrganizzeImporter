module OrganizzeImporter
  module Parsers
    class OFX < Base

      attr_reader :parsed_ofx

      delegate  :balance, :bank_id, :currency, :id,
                :transactions, :type, :to => :account

      def parse!
        @parsed_ofx = OFX(importer.file)
      end

      def account
        parsed_ofx.account
      end

      def collection
        account.transactions
      end

      def main_fields
        @main_fields ||= [:balance, :bank_id, :currency, :id, :transactions, :type]
      end

      def collection_fields
        @collection_fields ||= [:amount, :amount_in_pennies, :check_number, :fit_id, :memo, :name, :payee, :posted_at, :ref_number, :type]
      end

    end
  end
end
