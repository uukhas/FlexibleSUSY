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

#include "pv2.hpp"
#include "numerics2.hpp"

#include <algorithm>
#include <complex>
#include <cmath>
#include <limits>

namespace flexiblesusy {

namespace {

constexpr double EPSTOL = 1.0e-11; ///< underflow accuracy
constexpr double TOL = 1e-4;

constexpr double sqr(double a) noexcept { return a*a; }
constexpr double pow3(double a) noexcept { return a*a*a; }
constexpr double pow6(double a) noexcept { return a*a*a*a*a*a; }

bool is_close(double m1, double m2, double tol) noexcept
{
   using std::abs;
   const double mmax = abs(std::max(abs(m1), abs(m2)));
   const double mmin = abs(std::min(abs(m1), abs(m2)));
   const double max_tol = tol * mmax;

   if (max_tol == 0. && mmax != 0. && tol != 0.)
      return mmax - mmin <= tol;

   return mmax - mmin <= max_tol;
}

/// returns a/b if a/b is finite, otherwise returns numeric_limits::max()
template <typename T>
T divide_finite(T a, T b) noexcept {
   T result = a / b;
   if (!std::isfinite(result))
      result = std::numeric_limits<T>::max();
   return result;
}

double fB(const std::complex<double>& a) noexcept
{
   using flexiblesusy::fast_log;
   using std::abs;
   const double x = a.real();

   if (abs(x) < EPSTOL)
      return -1. - x + sqr(x) * 0.5;

   if (is_close(x, 1., EPSTOL))
      return -1.;

   return std::real(fast_log(1. - a) - 1. - a * fast_log(1.0 - 1.0 / a));
}

} // anonymous namespace

double a0(double m2, double q2) noexcept
{
   if (std::abs(m2) < 1e-8)
      return 0.;

   return m2 * (1.0 - std::log(std::abs(m2 / q2)));
}

/**
 * B0 function with squared arguments, from hep-ph/9606211.
 * Note it returns the REAL PART ONLY.
 */
double b0(double p2, double m12, double m22, double q2) noexcept
{
   using std::abs;
   using std::log;

   // protect against infrared divergence
   if (is_close(p2, 0., EPSTOL) && is_close(m12, 0., EPSTOL)
       && is_close(m22, 0., EPSTOL))
      return 0.;

   double ans = 0.;
   const double mMax2 = std::max(abs(m12), abs(m22));
   const double pTest = abs(divide_finite(p2, mMax2));

   if (pTest > 1e-10) {
      const double s = p2 - m22 + m12;
      const std::complex<double> iEpsilon(0., EPSTOL * mMax2);
      const std::complex<double> rt = sqrt(sqr(s) - 4.*p2*(m12 - iEpsilon));
      const std::complex<double> xPlus = 0.5 * (s + rt) / p2;
      const std::complex<double> xMinus = 0.5 * (s - rt) / p2;

      ans = -log(abs(p2 / q2)) - fB(xPlus) - fB(xMinus);
   } else {
      if (is_close(m12, m22, EPSTOL)) {
         ans = -log(abs(m12 / q2));
      } else {
         const double mMin2 = std::min(abs(m12), abs(m22));

         if (mMin2 < 1.e-30) {
            ans = 1. - log(abs(mMax2 / q2));
         } else {
            ans = (m12*(1. - log(abs(m12/q2))) - m22*(1. - log(abs(m22/q2))))
               / (m12 - m22);
         }
      }
   }

   return ans;
}

/**
 * Passarino-Veltman B1 function with squared mass arguments.
 * Not symmetric w.r.t. m1 and m2
 */
double b1(double p2, double m12, double m22, double q2) noexcept
{
   using std::abs;
   using std::log;

   // protect against infrared divergence
   if (is_close(p2, 0., EPSTOL) && is_close(m12, 0., EPSTOL)
       && is_close(m22, 0., EPSTOL))
      return 0.;

   double ans = 0.;
   const double mMax2 = std::max(abs(m12), abs(m22));
   const double pTest = divide_finite(p2, mMax2);

   /// Decides level at which one switches to p=0 limit of calculations
   const double pTolerance = 1e-4;

   if (pTest > pTolerance) {
      ans = (a0(m22,q2) - a0(m12,q2) + (p2 + m12 - m22)
             * b0(p2,m12,m22,q2)) / (2.*p2);
   } else if (abs(m12) > 1.0e-15 && abs(m22) > 1.0e-15) {
      const double m14 = sqr(m12), m24 = sqr(m22);
      const double m16 = m12*m14 , m26 = m22*m24;
      const double m18 = sqr(m14), m28 = sqr(m24);
      const double p4 = sqr(p2);
      if (abs(m12 - m22) < pTolerance * mMax2) {
         ans = 0.08333333333333333*p2/m22
            + 0.008333333333333333*p4/m24
            + sqr(m12 - m22)*(0.041666666666666664/m24 +
                              0.016666666666666666*p2/m26 +
                              0.005357142857142856*p4/m28)
            + (m12 - m22)*(-0.16666666666666666/m22 -
                           0.03333333333333333*p2/m24 -
                           0.007142857142857142*p4/m26)
            - 0.5*log(abs(m22/q2));
      } else {
         const double l12 = log(abs(m12/m22));

         ans = (3*m14 - 4*m12*m22 + m24 - 2*m14*l12)/(4.*sqr(m12 - m22))
            + (p2*(4*pow3(m12 - m22)*
                   (2*m14 + 5*m12*m22 - m24) +
                   (3*m18 + 44*m16*m22 - 36*m14*m24 - 12*m12*m26 + m28)*p2
                   - 12*m14*m22*(2*sqr(m12 - m22) + (2*m12 + 3*m22)*p2)*l12))/
            (24.*pow6(m12 - m22)) - 0.5*log(abs(m22/q2));
      }
   } else {
      // TODO:
      if (m12 > m22)
         ans = -0.5*log(abs(m12/q2)) + 0.75;
      else
         ans = -0.5*log(abs(m22/q2)) + 0.25;
   }

   return ans;
}

} // namespace flexiblesusy