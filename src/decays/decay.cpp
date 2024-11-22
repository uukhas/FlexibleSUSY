// ====================================================================
// This file is part of FlexibleSUSY.
//
// FlexibleSUSY is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// FlexibleSUSY is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FlexibleSUSY.  If not, see
// <http://www.gnu.org/licenses/>.
// ====================================================================

#include "decay.hpp"
#include "error.hpp"
#include "wrappers.hpp"

#include <boost/functional/hash.hpp>

#include <algorithm>
#include <sstream>

#include "string_utils.hpp"

namespace flexiblesusy {

namespace {

template <class Container>
std::size_t hash_pid_list(int pid_in, Container pids_out)
{
   Container sorted(pids_out);
   std::sort(sorted.begin(), sorted.end());

   boost::hash<int> hash_pid;
   auto seed = hash_pid(pid_in);
   boost::hash_range(seed, sorted.begin(), sorted.end());

   return seed;
}

} // anonymous namespace

std::size_t hash_decay(const Decay& decay)
{
   int pid_in = decay.get_initial_particle_id();
   const auto& pids_out = decay.get_final_state_particle_ids();
   return hash_pid_list(pid_in, pids_out);
}

Decays_list::Decays_list(int initial_pdg_)
   : initial_pdg(initial_pdg_)
{
}

void Decays_list::clear()
{
   decays.clear();
   total_width = 0.;
}

const Decay& Decays_list::get_decay(
   std::initializer_list<int> product_pdgs) const
{
   const Decay decay(initial_pdg, product_pdgs, 0., std::string());
   const auto decay_hash = hash_decay(decay);

   const auto pos = decays.find(decay_hash);

   if (pos == std::end(decays)) {
      std::ostringstream msg;
      msg << "Decay of particle " << initial_pdg
          << " into particles {"
          << concat(product_pdgs.begin(), product_pdgs.end(), ", ")
          << "} not found\n";

      throw OutOfBoundsError(msg.str());
   }

   return pos->second;
}

/**
 * Sort decays of every particle according to their width
 */
std::vector<Decay> sort_decays_list(const Decays_list& decays_list) {
   std::vector<Decay> decays_list_as_vector;
   decays_list_as_vector.reserve(decays_list.size());
   for (const auto& el : decays_list) {
      decays_list_as_vector.push_back(el.second);
   }

   std::sort(
      decays_list_as_vector.begin(),
      decays_list_as_vector.end(),
      [](const auto& d1, const auto& d2) {
         return d1.get_width() > d2.get_width();
      }
   );

   return decays_list_as_vector;
}

std::string strip_field_namespace(std::string const& s) {
   std::string result = s.substr(s.find_last_of(':')+1);
   if (s.find("bar") != std::string::npos) {
      result.pop_back();
      return "bar" + result;
   } else if (s.find("conj") != std::string::npos) {
      result.pop_back();
      return "conj" + result;
   } else {
      return result;
   }
}

double hVV_4body(double *q2, size_t /* dim */, void *params)
{
  struct hVV_4body_params * fp = static_cast<struct hVV_4body_params*>(params);
  const double mHOS = fp->mHOS;
  if (q2[1] > Sqr(mHOS - std::sqrt(q2[0]))) return 0.;
  const double mVOS = fp->mVOS;
  const double GammaV = fp->GammaV;
  const double kl = KallenLambda(1., q2[0]/Sqr(mHOS), q2[1]/Sqr(mHOS));
  return
     mVOS*GammaV/(Sqr(q2[0] - Sqr(mVOS)) + Sqr(mVOS*GammaV))
     * mVOS*GammaV/(Sqr(q2[1] - Sqr(mVOS)) + Sqr(mVOS*GammaV))
     * std::sqrt(kl)*(kl + 12.*q2[0]*q2[1]/Power4(mHOS));
}

} // namespace flexiblesusy
